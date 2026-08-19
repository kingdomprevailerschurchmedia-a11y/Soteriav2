# Fix for integration_test compilation error in release build

The build is failing because the `integration_test` plugin is being registered in the production `GeneratedPluginRegistrant.java`, but its Android dependencies are not being included in the release build classpath because it is listed under `dev_dependencies`.

Additionally, the project is using `compileSdk 36` and some non-standard Gradle configurations that might be interfering with the build process.

## Proposed Changes

### Build Configuration

#### [MODIFY] [pubspec.yaml](file:///C:/Joseph Project/Soteria/pubspec.yaml)
- Move `integration_test` from `dev_dependencies` to `dependencies`. This ensures that the plugin's Android component is available in all build configurations (debug, profile, release), which is required if Flutter's generation tool includes it in the registrant.

#### [MODIFY] [app/build.gradle.kts](file:///C:/Joseph Project/Soteria/android/app/build.gradle.kts)
- Downgrade `compileSdk` and `targetSdk` from `36` to `35`. SDK 36 is currently in preview, and using it can cause compatibility issues with plugins that haven't been updated to support it yet.
- Update `buildToolsVersion` to `35.0.0`.

#### [MODIFY] [build.gradle.kts](file:///C:/Joseph Project/Soteria/android/build.gradle.kts)
- Remove the `evaluationDependsOn(":app")` block from the `subprojects` section. This is a non-standard configuration that can cause circular dependency issues and evaluation order problems.
- Remove the `afterEvaluate` block that forces `compileSdk` to `35` for subprojects, as we will set it consistently in the app and let standard Flutter logic handle the rest.

## Verification Plan

### Manual Verification
1. Run `flutter clean` to ensure a fresh state.
2. Run `flutter build apk --split-per-abi` again.
3. Verify that the Java compilation error in `GeneratedPluginRegistrant.java` is resolved and the build completes successfully.
