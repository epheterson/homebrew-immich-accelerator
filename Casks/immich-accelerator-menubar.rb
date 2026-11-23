cask "immich-accelerator-menubar" do
  version "1.18.2"
  sha256 "e743348fa30d83183866e70a146a4c2e5834a781a6a385a1c41cd414b33fd1a6"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.18.2/immich-accelerator-menubar-1.18.2.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
