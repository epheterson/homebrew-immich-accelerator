cask "immich-accelerator-menubar" do
  version "1.12.0"
  sha256 "3b0fe54ad4df9dd63969c9b3a0718d22b75e9397ffebf35c382b4f7d52e90175"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.12.0/immich-accelerator-menubar-1.12.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
