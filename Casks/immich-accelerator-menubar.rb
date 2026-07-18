cask "immich-accelerator-menubar" do
  version "1.7.1"
  sha256 "5dbed7c9e22d4366dea25ce95703cbeca1557220b3dc273b9986ab43b560421f"

  url "https://github.com/epheterson/immich-apple-silicon/releases/download/v1.7.1/immich-accelerator-menubar-1.7.1.zip"
  name "Immich Accelerator Menu Bar"
  desc "Menu-bar status and controls for Immich Accelerator"
  homepage "https://github.com/epheterson/immich-apple-silicon"

  depends_on macos: :sonoma

  app "Immich Accelerator.app"

  # The app is ad-hoc signed (no Developer ID / notarization), so a
  # quarantined download would be Gatekeeper-blocked on first launch.
  # Strip the quarantine flag after install so it opens cleanly.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Immich Accelerator.app"]
  end
end
