cask "immich-accelerator-menubar" do
  version "1.17.11"
  sha256 "57d75bef4803f7b04e78409b7894b29bcfad484f07513b7e1b736fbe36b4a50e"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.11/immich-accelerator-menubar-1.17.11.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
