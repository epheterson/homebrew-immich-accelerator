cask "immich-accelerator-menubar" do
  version "1.11.0"
  sha256 "57bbb0d0dd5c23a5b3e5a3a8b4e1e820440bf1668fc7dc3ddeecc5e153d89955"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.11.0/immich-accelerator-menubar-1.11.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
