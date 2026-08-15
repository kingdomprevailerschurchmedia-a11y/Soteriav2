# Migrate Flutter Plugin/App to Built-in Kotlin

The project is currently experiencing a build failure due to a missing `integration_test` package in the generated plugin registrant and is not yet using the Flutter "Built-in Kotlin" Gradle plugin. This plan outlines the steps to migrate to the built-in Kotlin support and fix the build configuration.

## User Review Required

> [!IMPORTANT]
> The project currently uses "futuristic" versions of Gradle (9.7.0), AGP (9.3.1), and Kotlin (2.2.20). These versions are not yet stable or available in standard repositories. I will propose downgrading them to the latest stable versions to ensure compatibility with Flutter and its plugins.

## Proposed Changes

### Android Configuration

#### [MODIFY] [gradle.properties](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/android/gradle.properties)
- Set `android.builtInKotlin=true` to enable the built-in Kotlin Gradle plugin support.

#### [MODIFY] [settings.gradle](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/android/settings.gradle)
- Declare `org.jetbrains.kotlin.android` with a stable version (e.g., `2.0.20`).
- Use a stable AGP version (e.g., `8.7.3`).

#### [MODIFY] [build.gradle.kts](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/android/app/build.gradle.kts)
- Apply the `org.jetbrains.kotlin.android` plugin.
- Ensure `kotlinOptions.jvmTarget` is set (e.g., to `17` to match `compileOptions`).

#### [MODIFY] [gradle-wrapper.properties](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/android/gradle/wrapper/gradle-wrapper.properties)
- Downgrade Gradle to a stable version (e.g., `8.10.2`).

### Project Clean-up
- Run `flutter clean` and `flutter pub get` to regenerate `GeneratedPluginRegistrant.java` and ensure `integration_test` is correctly handled.

## Verification Plan

### Automated Tests
- Run `flutter build apk --release` to verify the build completes successfully.
- Run `flutter test` to ensure unit tests still pass.

### Manual Verification
- Verify that the app launches on an emulator/device.
