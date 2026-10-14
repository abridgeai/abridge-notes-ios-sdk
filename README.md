# Abridge Ambient Notes SDK for iOS

SwiftPM distribution of `AbridgeNotes.xcframework`. Each release is a tag; the
framework is in the repository, so adding the package is all that is required —
there is nothing to download, unzip or embed by hand.

Requires iOS 15 or later.

## Unreleased 1.1.0

Adds SDK error reporting and `stopEncounterRecordingWithId(encounterId:recordingId:)`.
The existing `stopEncounterRecording(encounterId:)` remains supported and sends no recording id.
The new id is persisted for retries and restoration; final-note correlation requires backend
support in the integration environment. See the Integration Guide for UUID requirements and
limitations. Finish pending encounters before downgrading to 1.0.0, which cannot read 1.1.0 records.

Before publishing, use the strict pinned-toolchain delivery artifact. Local builds are validation
artifacts.
Sentry's private client starts process-wide image caches and inspects host UI during event
preparation, before the outgoing-event allowlist removes host UI data. The pinned view-controller
lookup dispatches to the main thread; these reads are not evidence of a host-data leak.

## Adding it in Xcode

**File → Add Package Dependencies…**, enter this repository's URL, and choose
**Exact Version** with the release you want. Add the `AbridgeNotes` library to
your app target. Xcode embeds and signs the framework for you.

## Adding it in a Package.swift

```swift
dependencies: [
  .package(url: "https://github.com/abridgeai/abridge-notes-ios-sdk.git", exact: "1.1.0")
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

Sentry is merged into the framework for the SDK's own error reports. The SDK
never starts Sentry's process-wide SDK: it installs no crash or signal handler,
swizzles nothing and exports no symbols. Sentry's load-time initialization runs
when the framework loads. Beyond recording timestamps and the main thread's
identifier, it acts only if Sentry's app-launch profiling file exists, and then
may start a launch profile that samples your app's threads; only your app's own
Sentry writes that file. A report carries the SDK's error and lifecycle breadcrumbs,
the SDK version and environment, the partner and organization ids, the Abridge
encounter id, the iOS version, the device model, and your app's bundle
identifier and version. It never carries patient data, audio, transcripts,
provider identifiers, your app's user or device identifiers, or your app's
screens or stack frames. Reports go over HTTPS to `o576502.ingest.us.sentry.io`,
only to deliver the SDK's error reports — including any a previous run left
unsent, which can go from `initialize` — and what is sent is fixed per SDK
version, with no remote configuration. If your app uses Sentry itself, contact
Abridge first: two embedded copies register duplicate Objective-C class names,
and both read Sentry's app-launch profiling file. No analytics SDK is bundled.

The framework otherwise talks only to the Abridge API for the environment you
select. Its version is readable at runtime as `AbridgeClient.version`.

## Integration guide and release notes

The integration guide and the per-release notes are provided with the release
rather than kept here. Ask your Abridge contact if you do not have them.
