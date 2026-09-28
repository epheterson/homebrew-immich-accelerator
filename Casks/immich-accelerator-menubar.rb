cask "immich-accelerator-menubar" do
  version "1.17.4"
  sha256 "a6a970b36a4753d79a839a33c585aae054a535df8310eb20cf277bed76818a24"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.17.4/immich-accelerator-menubar-1.17.4.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
