class ImmichAccelerator < Formula
  desc "Run Immich compute natively on Apple Silicon"
  homepage "https://github.com/epheterson/immich-apple-silicon"
  url "https://github.com/epheterson/immich-apple-silicon/archive/refs/tags/v1.3.4.tar.gz"
  sha256 "c1bd4dc3cc09275df14e51c63c6551f0c1db2ca1820ac9bab246ef5b982e58b0"
  license "MIT"

  resource "ml" do
    url "https://github.com/epheterson/immich-ml-metal/archive/5f72fc38a3ec4d8fbce7d9ee219d03d80f8e0034.tar.gz"
    sha256 "a366b20717dc6ce07594068c36c02e973e2544b03b228f3a185e501f2b6c0393"
  end

  depends_on :macos
  depends_on arch: :arm64
  depends_on "node"
  depends_on "vips"
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
    # Create ML venv in post_install to avoid Homebrew dylib fixup
    # on Rust-compiled Python extensions (pydantic_core, tokenizers, etc.)
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
