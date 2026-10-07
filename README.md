# homebrew-immich-accelerator

[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/epheterson/homebrew-immich-accelerator/badge)](https://scorecard.dev/viewer/?uri=github.com/epheterson/homebrew-immich-accelerator)

Homebrew tap for [Immich Accelerator](https://github.com/epheterson/immich-apple-silicon), which runs Immich's compute natively on Apple Silicon.

```sh
brew tap epheterson/immich-accelerator
brew install immich-accelerator
brew install --cask immich-accelerator-menubar   # optional menu-bar app
```

The formula and cask are rewritten by the release workflow in the main repository; do not edit them by hand. Release assets there carry GitHub build-provenance attestations (`gh attestation verify <file> --repo epheterson/immich-apple-silicon`).
