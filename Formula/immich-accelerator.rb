class ImmichAccelerator < Formula
  desc "Run Immich compute natively on Apple Silicon"
  homepage "https://github.com/epheterson/immich-apple-silicon"
  url "https://github.com/epheterson/immich-apple-silicon/archive/refs/tags/v1.4.4.tar.gz"
  sha256 "34688d45e681233651788d91b71d7344984be90f51f1c5a6c90254daf4c89863"
  license "MIT"

  resource "ml" do
    url "https://github.com/epheterson/immich-ml-metal/archive/5ec33c4f221db78483daaa5b7c9e2cdfd640a62f.tar.gz"
    sha256 "090b5e51a55f40ad56eb1a79cadb40b2d34264e7ba495bca9620631df48a64d0"
  end

  depends_on :macos
  depends_on arch: :arm64
  # Immich 2.7.x pins engines.node = 24.x and sharp@0.34.5
  # native addons break on node 25 (brew's default 
  # formula). node@22 is the closest LTS with an arm64
  # bottle that satisfies Immich's range. Pin explicitly —
  # the accelerator's find_node() looks under
  # /opt/homebrew/opt/node@22/bin/node.
  depends_on "node@22"
  depends_on "vips"
  depends_on "libpq"
  depends_on "python@3.11"

  def install
    libexec.install Dir["*"]
    resource("ml").stage do
      (libexec/"ml").install Dir["*"]
    end
    # Wrapper uses the ML venv Python so the CLI inherits its
    # third-party deps (fastapi, uvicorn — required by the
    # dashboard and already pinned in ml/requirements.txt).
    # Prevents ModuleNotFoundError on fresh installs where
    # Homebrew's python3.11 has no extra packages. (Issue #17.)
    (bin/"immich-accelerator").write <<~SH
      #!/bin/bash
      VENV_PY="#{libexec}/ml/venv/bin/python3.11"
      if [ ! -x "\$VENV_PY" ]; then
        echo "immich-accelerator: ML venv missing or broken (expected: \$VENV_PY)." >&2
        echo "This usually means post_install failed during brew install/upgrade." >&2
        echo "Fix with: brew reinstall immich-accelerator" >&2
        exit 1
      fi
      export PYTHONPATH="#{libexec}:\$PYTHONPATH"
      cd "#{libexec}"
      exec "\$VENV_PY" -m immich_accelerator "\$@"
    SH
  end

  def post_install
    # ML venv in post_install avoids Homebrew dylib fixup on
    # Rust-compiled Python extensions (pydantic_core, tokenizers).
    # The CLI wrapper also runs through this venv — its existence
    # is load-bearing for every subcommand, not just ML.
    ml_dir = libexec/"ml"
    system Formula["python@3.11"].opt_bin/"python3.11", "-m", "venv", ml_dir/"venv"
    system ml_dir/"venv/bin/pip", "install", "-r", ml_dir/"requirements.txt"
  end

  def caveats
    <<~EOS
      To get started:
        immich-accelerator setup
    EOS
  end

  service do
    run [bin/"immich-accelerator", "watch"]
    keep_alive true
    log_path var/"log/immich-accelerator.log"
    error_log_path var/"log/immich-accelerator-error.log"
  end

  test do
    # --version exits before lazy third-party imports load, so
    # it's not enough on its own. Force-load the dashboard app
    # so we catch ModuleNotFoundError on fastapi/uvicorn at
    # brew audit / brew test time instead of in the wild.
    assert_match "immich-accelerator", shell_output("#{bin}/immich-accelerator --version")
    system "#{libexec}/ml/venv/bin/python3.11", "-c",
           "import sys; sys.path.insert(0, '#{libexec}'); " \
           "from immich_accelerator.dashboard import create_app; " \
           "create_app({'version':'test','immich_url':'http://x','api_key':''})"
  end
end
