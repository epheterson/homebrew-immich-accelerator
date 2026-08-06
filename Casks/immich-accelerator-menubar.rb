cask "immich-accelerator-menubar" do
  version "1.8.0"
  sha256 "b7e53df4a028b19f2de3f794fda09555140195d7b8c78f46fd21de8b991a929b"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.8.0/immich-accelerator-menubar-1.8.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
