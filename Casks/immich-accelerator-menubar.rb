cask "immich-accelerator-menubar" do
  version "1.17.2"
  sha256 "182f1c7a8063d2a5328846f0f02859863523e904ad7f1cecac2dbb1726a1ee36"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.2/immich-accelerator-menubar-1.17.2.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
