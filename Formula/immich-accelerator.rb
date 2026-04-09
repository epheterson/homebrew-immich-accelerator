class ImmichAccelerator < Formula
  desc "Run Immich compute natively on Apple Silicon"
  homepage "https://github.com/epheterson/immich-apple-silicon"
  url "https://github.com/epheterson/immich-apple-silicon/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "d6c87ed02382d92323e4ea0c049336b4389c41b4f0db671757fc61eabb8767de"
  license "MIT"

  resource "ml" do
    url "https://github.com/epheterson/immich-ml-metal/archive/9561a6d5dded7a06f0e3c780b5693c328c6fd7c7.tar.gz"
    sha256 "b55cde836638bb7339c80242e743e611271872e9add4c41f1263c74f0255821b"
  end

  depends_on :macos
  depends_on arch: :arm64
  depends_on "node"
  depends_on "vips"
  depends_on "libpq"
  depends_on "python@3.11"

  def install
    libexec.install Dir["*"]
    resource("ml").stage do
      (libexec/"ml").install Dir["*"]
    end
    (bin/"immich-accelerator").write <<~SH
      #!/bin/bash
      export PYTHONPATH="#{libexec}:\$PYTHONPATH"
      cd "#{libexec}"
      exec "#{Formula["python@3.11"].opt_bin}/python3.11" -m immich_accelerator "\$@"
    SH
  end

  def post_install
    # ML venv in post_install avoids Homebrew dylib fixup on
    # Rust-compiled Python extensions (pydantic_core, tokenizers)
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
    assert_match "immich-accelerator", shell_output("#{bin}/immich-accelerator --version")
  end
end
