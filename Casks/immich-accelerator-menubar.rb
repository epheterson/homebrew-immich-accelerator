cask "immich-accelerator-menubar" do
  version "1.17.9"
  sha256 "4718798d3851b9aa6ea4001b94ca886d7b319659638677da88f15e86d9caf1b2"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.9/immich-accelerator-menubar-1.17.9.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
