cask "immich-accelerator-menubar" do
  version "1.17.10"
  sha256 "bd28e95f2866b916a89ddc69003504e44bd8149c65a54047ff9d09b91d2c6918"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.10/immich-accelerator-menubar-1.17.10.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
