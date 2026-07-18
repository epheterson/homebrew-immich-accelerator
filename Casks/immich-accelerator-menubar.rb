cask "immich-accelerator-menubar" do
  version "1.7.0"
  sha256 "e3a2161e11a87744cc2f3a19cfb4277ae9ad7a85f0015743cb1f5dc4ab06f8f4"
  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.7.0/immich-accelerator-menubar-1.7.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"
  depends_on macos: ">= :sonoma"
  app "Immich Accelerator.app"
end
