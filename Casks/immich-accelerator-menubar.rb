cask "immich-accelerator-menubar" do
  version "1.13.0"
  sha256 "1e20a0ec38444c0208bb91e5b1d3986fb3a596006a599a44df9c6ad9949e0c61"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.13.0/immich-accelerator-menubar-1.13.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
