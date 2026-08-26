cask "immich-accelerator-menubar" do
  version "1.16.0"
  sha256 "e8e218a52a563b7b73d34d4520405511c587fa53d6b673c0a5a8a28301cd1fcf"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.16.0/immich-accelerator-menubar-1.16.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
