cask "immich-accelerator-menubar" do
  version "1.17.3"
  sha256 "6b2fd6e48f795694f39c804536de47c107b4afc7db72e05c12a09298e6e74dfa"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.3/immich-accelerator-menubar-1.17.3.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
