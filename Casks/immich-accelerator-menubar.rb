cask "immich-accelerator-menubar" do
  version "1.16.1"
  sha256 "d3fd81456f7aff1e3e53027c72692c3641f3d95afc2bbe8199a849c0f75afad9"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.16.1/immich-accelerator-menubar-1.16.1.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
