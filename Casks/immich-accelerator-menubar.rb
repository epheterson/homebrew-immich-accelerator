cask "immich-accelerator-menubar" do
  version "1.14.0"
  sha256 "1e1a6809a071319052877656f138d6004644e235b4824005e9fdaf2d1e02eed2"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.14.0/immich-accelerator-menubar-1.14.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
