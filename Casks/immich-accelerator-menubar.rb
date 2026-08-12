cask "immich-accelerator-menubar" do
  version "1.10.0"
  sha256 "4a592caef038c210097f3b1ed0916775d91fe0ebd51f21a1dcf93a5529052c2a"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.10.0/immich-accelerator-menubar-1.10.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
