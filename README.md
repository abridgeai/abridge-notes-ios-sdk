# Abridge Ambient Notes SDK for iOS

SwiftPM distribution of `AbridgeNotes.xcframework`. Each release is a tag; the
framework is in the repository, so adding the package is all that is required —
there is nothing to download, unzip or embed by hand.

Requires iOS 15 or later.

## Adding it in Xcode

**File → Add Package Dependencies…**, enter this repository's URL, and choose
**Exact Version** with the release you want. Add the `AbridgeNotes` library to
your app target. Xcode embeds and signs the framework for you.

## Adding it in a Package.swift

```swift
dependencies: [
  .package(url: "https://github.com/abridgeai/abridge-notes-ios-sdk.git", exact: "0.1.0")
],
targets: [
  .target(
    name: "YourApp",
    dependencies: [
      .product(name: "AbridgeNotes", package: "abridge-notes-ios-sdk")
    ]
  )
]
```

Then `import AbridgeNotes`.

## Also required in your app target

- `NSMicrophoneUsageDescription` in `Info.plist` — iOS requires it before the
  SDK can capture audio.
- `UIBackgroundModes` containing `audio` — otherwise iOS suspends the audio
  engine when the app leaves the foreground and recording stops.

The SDK does not request microphone permission and does not check it before a
start. Request it yourself and get a grant before the first
`startEncounterRecording`.

## What is in the framework

Device (`arm64`) and simulator slices, module-stable across Xcode releases,
usable from Swift 5 and Swift 6 language modes. Debug symbols (dSYMs) ship
inside each slice, and a privacy manifest sits at the root of the framework
bundle. The audio pipeline and Opus encoder are merged in — nothing else needs
linking.

No analytics or crash-reporting SDK is bundled. The framework talks only to the
Abridge API for the environment you select. Its version is readable at runtime
as `AbridgeClient.version`.

## Integration guide and release notes

The integration guide and the per-release notes are provided with the release
rather than kept here. Ask your Abridge contact if you do not have them.
