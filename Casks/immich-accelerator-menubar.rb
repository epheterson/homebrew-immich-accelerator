cask "immich-accelerator-menubar" do
  version "1.18.3"
  sha256 "00562b7292b387bbd202915ac659bb46b170a02e0ed9dc534ea1c76f85f1df18"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.18.3/immich-accelerator-menubar-1.18.3.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
