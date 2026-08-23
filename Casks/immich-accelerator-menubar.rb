cask "immich-accelerator-menubar" do
  version "1.15.0"
  sha256 "a25e507f041ceb12a8e7a1bfb4951b0ea6c3b450c1625cb65a04bca5a65dce87"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.15.0/immich-accelerator-menubar-1.15.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
