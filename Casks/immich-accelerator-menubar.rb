cask "immich-accelerator-menubar" do
  version "1.17.8"
  sha256 "4b31d97bc355dbaff0bca5362a4b1867a4353ebf4c71f7ef41a62b103dc3fe9b"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.8/immich-accelerator-menubar-1.17.8.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
