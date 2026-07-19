cask "immich-accelerator-menubar" do
  version "1.7.2"
  sha256 "1ecd1b5bc944715e070964300e79303c3d46ea8e380c26672ba14807781342c2"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.7.2/immich-accelerator-menubar-1.7.2.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
