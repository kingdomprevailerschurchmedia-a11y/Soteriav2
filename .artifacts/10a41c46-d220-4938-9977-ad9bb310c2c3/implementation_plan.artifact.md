# Implementation Plan - Fix Android Resource Linking Error (Missing `android12splash`)

The Android build for Soteria is failing during resource linking because `android12splash` is referenced in the `v31` (Android 12+) style files but is missing from the drawable resources. This is a common issue when `flutter_native_splash` configuration exists in `pubspec.yaml` but the generation command hasn't been run or some generated files were lost.

## User Review Required

> [!IMPORTANT]
> This plan involves running `flutter pub run flutter_native_splash:create`. This will overwrite existing native splash files in `android/app/src/main/res` and `ios/Runner`. Since the `pubspec.yaml` already contains the desired configuration, this should be safe and is the intended way to fix this inconsistency.

## Proposed Changes

### Native Splash Generation
- Run the `flutter_native_splash:create` command to generate all required Android and iOS resources based on the configuration in `pubspec.yaml`.

### Resource Verification
- Confirm that `android12splash.xml` (or the equivalent resource referenced in `styles.xml`) is present in the `android/app/src/main/res/drawable` (or appropriate density) folders.

## Verification Plan

### Automated Tests
- Run `flutter build apk --debug` to ensure the resource linking error is resolved and the build completes successfully.

### Manual Verification
- Verify the splash screen appears correctly on an Android 12+ emulator/device (if available).
