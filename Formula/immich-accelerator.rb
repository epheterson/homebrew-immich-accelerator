class ImmichAccelerator < Formula
  desc "Run Immich compute natively on Apple Silicon"
  homepage "https://github.com/epheterson/immich-apple-silicon"
  url "https://github.com/epheterson/immich-apple-silicon/archive/refs/tags/v1.7.0.tar.gz"
  sha256 "4bcce3650b043e2fd67972f0bfee3673673cbeb5fc4cc82de28717c56b734b7e"
  license "MIT"

  resource "ml" do
    url "https://github.com/epheterson/immich-ml-metal/archive/eecfea2b20fb8cfefb722a599622b4d00d29852d.tar.gz"
    sha256 "6df935cc68eebb957adef59bdb5a8c2062afc874bca34b24f059d3009847ec31"
  end

  resource "native_ml" do
    url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.7.0/immich-ml-native-1.7.0-macos-arm64.tar.gz"
    sha256 "ffa3db6f70d39e7c4c48a80459ed57ee0e4309f5709c3aa4e8a23a7e561fa2a6"
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
    resource("native_ml").stage do
      (libexec/"native-ml").install Dir["*"]
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
      # Don't write .pyc into the Cellar. Python would otherwise
      # create __pycache__ next to the installed modules; if the CLI
      # is ever run as root (sudo, or a root service) those files are
      # root-owned and break "brew cleanup". (Issue #86.)
      export PYTHONDONTWRITEBYTECODE=1
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
    venv_py = ml_dir/"venv/bin/python3.11"
    system Formula["python@3.11"].opt_bin/"python3.11", "-m", "venv", ml_dir/"venv"
    # The ML deps are a large download (torch, pulled in by mlx_clip, is a
    # few hundred MB), so a flaky connection is the common install failure
    # (issues #17, #105). Retry once so a transient blip self-recovers; a
    # deterministic failure still raises on the second try.
    tries = 0
    begin
      tries += 1
      system venv_py, "-m", "pip", "install", "-r", ml_dir/"requirements.txt"
    rescue
      retry if tries < 2
      raise
    end
    # Fail the install LOUDLY if the venv still lacks what the CLI, dashboard
    # and ML service need, instead of shipping a venv that exists but is
    # missing deps and only errors at runtime with ModuleNotFoundError
    # (issues #17, #105). system aborts on non-zero, so a broken install is
    # visible and "brew reinstall immich-accelerator" fixes it.
    verify_ml_venv venv_py
  end

  # Single source of truth for "the venv has what the CLI, dashboard and ML
  # service need." Called at install time (to fail a broken install loudly)
  # and from brew test. Imports the load-bearing packages and builds the
  # dashboard app, so a partial pip install (missing fastapi/uvicorn, or a
  # broken compiled mlx.core / torch via mlx_clip) is caught rather than
  # crashing at runtime (#17, #105). NOTE: no backticks in this heredoc,
  # they are command substitution and corrupt the generated formula. Uses
  # import mlx.core, not bare import mlx (an empty namespace that imports
  # even when the compiled extension is missing).
  def verify_ml_venv(venv_py)
    system venv_py, "-c", "import sys; sys.path.insert(0, '#{libexec}'); import fastapi, uvicorn; import mlx.core, mlx.nn; import mlx_clip; from immich_accelerator.dashboard import create_app; create_app({'version':'test','immich_url':'http://x','api_key':''})"
  end

  def caveats
    <<~EOS
      To get started:
        immich-accelerator setup

      Homebrew 5.1.15+ silently skips untrusted taps during upgrades.
      So future releases reach you, run once:
        brew trust epheterson/immich-accelerator
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
    verify_ml_venv "#{libexec}/ml/venv/bin/python3.11"
  end
end
