cask "immich-accelerator-menubar" do
  version "1.17.5"
  sha256 "02baa5ea59313b58aff9b4618f9e42eb2e1a8faa52d43b7f1b6267cf92afef4d"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.5/immich-accelerator-menubar-1.17.5.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
