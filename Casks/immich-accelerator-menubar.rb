cask "immich-accelerator-menubar" do
  version "1.17.12"
  sha256 "a1646de95b00f198068d8fcab316639bb23c8a93fbd7b7f3f43fe342aea79382"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.12/immich-accelerator-menubar-1.17.12.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
