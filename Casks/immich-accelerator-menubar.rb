cask "immich-accelerator-menubar" do
  version "1.17.7"
  sha256 "b1fc4b1a6b7b8fdb8bd48bdf9f147c4e5ec230f31ad16bd2a63a225789c89057"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.7/immich-accelerator-menubar-1.17.7.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
