cask "immich-accelerator-menubar" do
  version "1.17.13"
  sha256 "64d207bc41f809c47bf3d4d02932895b57d90bd6c6d0c9e9d6220dbb0f843d40"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.13/immich-accelerator-menubar-1.17.13.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
