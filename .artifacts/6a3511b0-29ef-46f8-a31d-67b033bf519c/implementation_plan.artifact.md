# Implementation Plan - Unified Native Splash Screen

Unify the startup experience by replacing the two-stage splash screen (Native + Flutter) with a single Native Splash Screen that stays visible until the application is fully initialized.

## User Review Required

> [!IMPORTANT]
> The Flutter `SplashScreen` included animations (ScaleIn, FadeIn) for the logo and text. Native splash screens (especially on Android 12+) have limited animation support. The new experience will be a static, premium native splash that transitions directly to the first interactive screen (Dashboard or Sign In).

> [!WARNING]
> The "Exactly Identical" requirement for the native splash screen is challenging due to platform-specific constraints (e.g., Android 12 splash icon size limits). I will use `flutter_native_splash` to get as close as possible, but some minor layout differences may occur between platforms.

## Proposed Changes

### Native Configuration

#### [MODIFY] [pubspec.yaml](file:///C:/Joseph%20Project/pubspec.yaml)
- Update `flutter_native_splash` configuration to match `SplashScreen` colors and images.
- Adjust background color to `#0B012A`.
- Ensure `android_12` settings are correctly configured.

### Flutter Startup Logic

#### [MODIFY] [main.dart](file:///C:/Joseph%20Project/lib/main.dart)
- Initialize `widgetsBinding`.
- Call `FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding)` to keep the native splash visible.

#### [MODIFY] [lib/core/identity/providers/identity_providers.dart](file:///C:/Joseph%20Project/lib/core/identity/providers/identity_providers.dart)
- Inject a call to `FlutterNativeSplash.remove()` when the `AppStartupState` transitions from `loading` to any other state.
- This ensures the native splash is only removed once the app has determined its destination (Onboarding, Auth, or Dashboard).

#### [MODIFY] [lib/core/app/app.dart](file:///C:/Joseph%20Project/lib/core/app/app.dart)
- Remove the `firebaseInitFutureProvider` check in the `build` method.
- Remove `_BootstrapWrapper` and `SplashScreen` usage.
- Ensure `SoteriaApp` always builds the main `MaterialApp.router`.

#### [MODIFY] [lib/core/navigation/app_router.dart](file:///C:/Joseph%20Project/lib/core/navigation/app_router.dart)
- Remove `SoteriaRoutes.splash` from the route list.
- Update `initialLocation` to `SoteriaRoutes.main` (or another appropriate default, as the redirect logic will handle the actual destination).
- Remove the redirect logic that points to `SoteriaRoutes.splash`.

### Cleanup

#### [DELETE] [splash_screen.dart](file:///C:/Joseph%20Project/lib/features/splash/splash_screen.dart)
- Delete the Flutter splash screen widget.

#### [DELETE] [initialization_failure_screen.dart](file:///C:/Joseph%20Project/lib/features/splash/initialization_failure_screen.dart)
- Delete the failure screen as per the "remove every unused splash-related file" requirement.
- *Note*: We may need a basic error UI in `app.dart` if Firebase fails, but it will be handled by the `firebaseInitFutureProvider.when` error state (which we should keep or move).

#### [MODIFY] [soteria_routes.dart](file:///C:/Joseph%20Project/lib/core/navigation/soteria_routes.dart)
- Remove `splash` constant.

## Verification Plan

### Automated Tests
- Run `flutter test` to ensure no regressions in navigation or identity providers.

### Manual Verification
- **Cold Start**: Verify the app shows the native splash and transitions directly to Dashboard (authenticated) or Auth Landing (guest) without a second splash screen.
- **Visual Check**: Compare the new native splash with the previous Flutter splash (using provided design values).
- **Android 12+**: Verify the splash screen on an Android 12+ emulator/device.
- **Navigation**: Ensure the app no longer attempts to navigate to `/`.
