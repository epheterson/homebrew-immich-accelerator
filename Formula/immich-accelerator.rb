class ImmichAccelerator < Formula
  desc "Run Immich compute natively on Apple Silicon"
  homepage "https://github.com/epheterson/immich-apple-silicon"
  url "https://github.com/epheterson/immich-apple-silicon/archive/refs/tags/v1.3.3.tar.gz"
  sha256 "716027c7c25ee1215e47d43b8a910f1c9bce7180cfb2a7eb6bc05282a0f78242"
  license "MIT"

  resource "ml" do
    url "https://github.com/epheterson/immich-ml-metal/archive/00640a40ced11084cf987cff6f0db7863f35c402.tar.gz"
    sha256 "0d17fdfac24cbfbbd761a6667c2ac5fa336338afec34bdf45183f6f7c20769dd"
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
    ml_dir = libexec/"ml"
    system Formula["python@3.11"].opt_bin/"python3.11", "-m", "venv", ml_dir/"venv"
    system ml_dir/"venv/bin/pip", "install", "-r", ml_dir/"requirements.txt"
    (bin/"immich-accelerator").write <<~SH
      #!/bin/bash
      export PYTHONPATH="#{libexec}:\$PYTHONPATH"
      cd "#{libexec}"
      exec "#{Formula["python@3.11"].opt_bin}/python3.11" -m immich_accelerator "\$@"
    SH
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
