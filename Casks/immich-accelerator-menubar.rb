cask "immich-accelerator-menubar" do
  version "1.9.0"
  sha256 "5b91560de0d0d49eee481d26a07c0183ac7950a673bf2438abb2ea3fc29b65c1"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.9.0/immich-accelerator-menubar-1.9.0.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app", target: "#{Dir.home}/Applications/Immich Accelerator.app"
end
