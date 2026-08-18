cask "immich-accelerator-menubar" do
  version "1.11.1"
  sha256 "ca5a0cbefddfdce7dbe038c581be9623dbc8ad2d9c4fa2d54db7e16944bd3e82"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.11.1/immich-accelerator-menubar-1.11.1.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
