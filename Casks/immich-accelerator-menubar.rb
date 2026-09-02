cask "immich-accelerator-menubar" do
  version "1.17.0"
  sha256 "aad5cc5e0d6d046fe98caf3e0c50f5184c2712713ded3aa1caf66707859a51e1"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.0/immich-accelerator-menubar-1.17.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
