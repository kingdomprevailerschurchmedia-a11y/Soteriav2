# Fix Flutter Build Failure (Android compileSdk and AAR Metadata)

The build is failing because several dependencies require a `compileSdk` of at least 34, while some plugins (like `:flutter_native_splash`) are being compiled against Android 31. Additionally, the project is currently using experimental versions of Android Gradle Plugin (9.3.1) and Gradle (9.7.0), which may be causing secondary service initialization errors.

## User Review Required

> [!IMPORTANT]
> I am proposing to downgrade the Android Gradle Plugin (AGP) and Gradle to stable versions (8.7.3 and 8.10.2 respectively) to ensure compatibility and stability. I will also force all plugins to use a consistent `compileSdk` version.

## Proposed Changes

### Android Build Configuration

#### [MODIFY] [build.gradle.kts](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/android/build.gradle.kts)
- Add a `subprojects` block to override `compileSdkVersion` for all plugins to ensure they meet the minimum requirement of 34.

#### [MODIFY] [app/build.gradle.kts](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/android/app/build.gradle.kts)
- Update `compileSdk` and `targetSdk` to 35 (Android 15) to ensure full compatibility with modern dependencies.

#### [MODIFY] [settings.gradle](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/android/settings.gradle)
- Downgrade AGP version from `9.3.1` to `8.7.3`.

#### [MODIFY] [gradle-wrapper.properties](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/android/gradle/wrapper/gradle-wrapper.properties)
- Downgrade Gradle version from `9.7.0` to `8.10.2`.

### Pub Dependencies

#### [MODIFY] [pubspec.yaml](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/pubspec.yaml)
- Explicitly upgrade `flutter_native_splash` to `2.4.8` and ensure other dependencies are at compatible versions.

## Verification Plan

### Automated Tests
- Run `flutter clean`
- Run `flutter pub get`
- Run `flutter build apk --release --split-per-abi` to verify the build completes successfully.
