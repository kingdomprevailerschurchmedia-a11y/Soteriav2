# Implementation Plan - Rename Package Name to `com.soteria.app`

This plan outlines the steps to change the application's package name (Android) and bundle identifier (iOS) from `com.soteria.soteria` to `com.soteria.app`.

## User Review Required

> [!IMPORTANT]
> **Firebase & Google Services**: Changing the package name will break existing Firebase integrations (Google Sign-In, Analytics, etc.) because the identifier in `google-services.json` and `GoogleService-Info.plist` will no longer match the app's ID.
>
> After I apply these changes, you **must**:
> 1.  Update the Android app ID in the Firebase Console.
> 2.  Download the new `google-services.json` and replace the existing one in `android/app/`.
> 3.  Update the iOS bundle ID in the Firebase Console.
> 4.  Download the new `GoogleService-Info.plist` and replace the existing one in `ios/Runner/`.

## Proposed Changes

### Android

#### [MODIFY] [android/app/build.gradle.kts](file:///C:/Joseph%20Project/android/app/build.gradle.kts)
- Update `namespace` from `"com.soteria.soteria"` to `"com.soteria.app"`.
- Update `applicationId` from `"com.soteria.soteria"` to `"com.soteria.app"`.

#### [MODIFY] [android/app/src/main/kotlin/com/soteria/soteria/MainActivity.kt](file:///C:/Joseph%20Project/android/app/src/main/kotlin/com/soteria/soteria/MainActivity.kt)
- Update the package declaration at the top of the file to `package com.soteria.app`.

#### [MOVE]
- Move `android/app/src/main/kotlin/com/soteria/soteria/MainActivity.kt` to `android/app/src/main/kotlin/com/soteria/app/MainActivity.kt`.

### iOS

#### [MODIFY] [ios/Runner.xcodeproj/project.pbxproj](file:///C:/Joseph%20Project/ios/Runner.xcodeproj/project.pbxproj)
- Replace all occurrences of `com.soteria.soteria` with `com.soteria.app`.

---

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no broken references.
- Run `flutter build apk --debug` to verify the Android build still works with the new package name.

### Manual Verification
- Verify the directory structure in `android/app/src/main/kotlin/` matches the new package name.
- Check the generated Android manifest (after build) to ensure the package name is correct.
