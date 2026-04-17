class ImmichAccelerator < Formula
  desc "Run Immich compute natively on Apple Silicon"
  homepage "https://github.com/epheterson/immich-apple-silicon"
  url "https://github.com/epheterson/immich-apple-silicon/archive/refs/tags/v1.4.7.tar.gz"
  sha256 "6e7ad322bf3a8520fb6b9e2800d19201eebfd34d734d6f1dad3cac205a271d76"
  license "MIT"

  resource "ml" do
    url "https://github.com/epheterson/immich-ml-metal/archive/5ec33c4f221db78483daaa5b7c9e2cdfd640a62f.tar.gz"
    sha256 "090b5e51a55f40ad56eb1a79cadb40b2d34264e7ba495bca9620631df48a64d0"
  end

  depends_on :macos
  depends_on arch: :arm64
  # node@22 is the keg-only LTS that satisfies Immich's
  # engines.node pin. The default node formula tracks
  # mainline (currently 25.x) which breaks sharp's native
  # addons with NODE_MODULE_VERSION mismatches.
  depends_on "node@22"
  depends_on "vips"
  depends_on "libpq"
  depends_on "python@3.11"
  # GNU gzip for gzip --rsyncable. Apple's BSD gzip does
  # not support that flag, and Immich's database-backup
  # service pipes pg_dump stdout through it.
  depends_on "gzip"

  def install
    libexec.install Dir["*"]
    resource("ml").stage do
      (libexec/"ml").install Dir["*"]
    end
    # Wrapper uses the ML venv Python so the CLI inherits its
    # third-party deps (fastapi, uvicorn - required by the
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
    # The CLI wrapper also runs through this venv - its existence
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
