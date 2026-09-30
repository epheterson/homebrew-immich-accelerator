cask "immich-accelerator-menubar" do
  version "1.17.6"
  sha256 "a5c329e386d1040c74b41e26051511c057c2f80e0594c510ef4a8708283697e9"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.6/immich-accelerator-menubar-1.17.6.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
