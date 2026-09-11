cask "immich-accelerator-menubar" do
  version "1.17.1"
  sha256 "0c25b786e8e5b7c59ac71cd3a040675275a17dad53622776d04a493ef3330692"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.1/immich-accelerator-menubar-1.17.1.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
