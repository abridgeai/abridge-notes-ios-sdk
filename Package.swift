// swift-tools-version: 5.9

// The manifest athena resolves. This file is the reviewed source for the copy
// committed at the root of the distribution repository
// (abridgeai/abridge-notes-ios-sdk) — a change here does nothing until it is
// copied there, the same relationship ci/athena-sdk-deliver.workflow.yml has
// with the installed Bitrise workflow.
//
// It carries no version. The version is the git tag the distribution repository
// is released under, so this file is identical for every release and there is
// nothing to render per release.
//
// A binary target by path, not by url and checksum: the xcframework is
// committed beside this manifest rather than downloaded. SwiftPM will only
// fetch a binary target over https and cannot authenticate that download
// cleanly, so a hosted archive would have to be reachable unauthenticated. A
// private repository with the framework inside needs no download leg at all —
// Xcode clones it with the developer's existing credentials — and keeps access
// grantable and revocable.

import PackageDescription

let package = Package(
  name: "AbridgeNotes",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "AbridgeNotes", targets: ["AbridgeNotes"])
  ],
  targets: [
    .binaryTarget(
      name: "AbridgeNotes",
      path: "AbridgeNotes.xcframework"
    )
  ]
)
