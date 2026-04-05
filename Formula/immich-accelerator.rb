class ImmichAccelerator < Formula
  desc "Run Immich compute natively on Apple Silicon"
  homepage "https://github.com/epheterson/immich-apple-silicon"
  url "https://github.com/epheterson/immich-apple-silicon/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "ce76f30fec37f1a44e6557729481dbad4da6daa354d1ca377bf6fffc19305aa1"
  license "MIT"

  depends_on :macos
  depends_on :arch => :arm64
  depends_on "node"
  depends_on "vips"
  depends_on "python@3.11"

  def install
    # Install the immich_accelerator package and ML service
    libexec.install Dir["*"]

    # Create ML venv
    ml_dir = libexec/"ml"
    system Formula["python@3.11"].opt_bin/"python3.11", "-m", "venv", ml_dir/"venv"
    system ml_dir/"venv/bin/pip", "install", "-r", ml_dir/"requirements.txt"

    # Create wrapper script that sets PYTHONPATH to find the module
    (bin/"immich-accelerator").write <<~SH
      #!/bin/bash
      export PYTHONPATH="#{libexec}:$PYTHONPATH"
      cd "#{libexec}"
      exec "#{Formula["python@3.11"].opt_bin}/python3.11" -m immich_accelerator "$@"
    SH
  end

  def post_install
    # Download jellyfin-ffmpeg on first install
    system bin/"immich-accelerator", "--version"
  end

  def caveats
    <<~EOS
      To get started:
        immich-accelerator setup

      This will detect your Immich instance, configure everything,
      and offer to start services + install auto-launch on login.
    EOS
  end

  service do
    run [bin/"immich-accelerator", "watch"]
    working_dir var/"immich-accelerator"
    keep_alive true
    log_path var/"log/immich-accelerator.log"
    error_log_path var/"log/immich-accelerator-error.log"
  end

  test do
    assert_match "immich-accelerator", shell_output("#{bin}/immich-accelerator --version")
  end
end
