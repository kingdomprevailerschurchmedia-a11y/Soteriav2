# Splash Screen Performance & Stability Optimization

The application currently experiences a 15-20 second delay during startup, primarily due to main thread blocking and sequential initialization of services that depend on Google Play Services (which appears unstable on the current emulator/device).

## Proposed Changes

### [Core] [app.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/app/app.dart)
- [MODIFY] Implement a "fast-path" splash UI that renders immediately while Firebase initializes.
- [MODIFY] Move `FlutterNativeSplash.remove()` to the earliest possible frame in the custom loading UI.
- [MODIFY] Stagger the initialization of background coordinators (`Notification`, `Configuration`, `Presence`) to avoid a massive burst of platform channel calls and Firestore queries during startup.

### [Firebase] [firebase_bootstrapper.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/firebase/initializer/firebase_bootstrapper.dart)
- [MODIFY] Move `initializeAppCheck` and `initializeGoogleSignIn` to `unawaited` background tasks. This prevents startup from hanging if Google Play Services is unresponsive or slow to provide tokens.

### [Navigation] [app_router.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/navigation/app_router.dart)
- [MODIFY] Disable `debugLogDiagnostics` in `GoRouter` to reduce main-thread overhead during the initial route analysis and build.

### [UI] [New] [splash_static_view.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/splash/presentation/widgets/splash_static_view.dart)
- [NEW] A "pure" UI widget that mirrors the `SplashScreen` branding but has zero dependencies on Riverpod or Firebase, allowing it to be used as a placeholder during the bootstrapping phase.

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no regression in static analysis.
- Verify `SoteriaApp` renders correctly in a minimal test environment.

### Manual Verification
- Observe the logcat for `Davey!` logs and frame skip warnings.
- Measure the time from app launch to the native splash disappearing (target: < 2s).
- Measure the time from launch to the Dashboard being usable (target: < 8s on cold start).
