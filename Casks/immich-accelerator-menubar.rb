cask "immich-accelerator-menubar" do
  version "1.18.0"
  sha256 "f8d1ec5a9438aedfab08687abf4151b3a13fe3b006e3d799739b136eb1af5625"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.18.0/immich-accelerator-menubar-1.18.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
