# Implementation Plan - Custom Splash Screen Migration

Migrate the native splash screen to a premium, custom Flutter splash screen while maintaining a seamless transition using a minimal native splash as a bridge.

## Proposed Changes

### Native Configuration

#### [MODIFY] [pubspec.yaml](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/pubspec.yaml)
- Simplify `flutter_native_splash` configuration:
  - Remove `background_image`, `image`, and branding.
  - Set `color` to `#090514`.
  - Update `android_12` section to match.

### Splash Feature

#### [NEW] [splash_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/splash/presentation/screens/splash_screen.dart)
- Implement a responsive splash screen using `splash_bg.png` and `logo_icon.png`.
- Add entrance animations:
  - Logo: Fade and scale (0.94 -> 1.0).
  - Branding (if separate): Fade in.
- Handle `FlutterNativeSplash.remove()` after the first frame.
- Monitor `appLifecycleProvider` and wait for a minimum duration (1.5s - 2.0s) before allowing transition to the next destination.

#### [NEW] [splash_branding.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/splash/presentation/widgets/splash_branding.dart)
- Component for rendering the logo and tagline if they are not already in `splash_bg.png`.

### Core Architecture & Routing

#### [MODIFY] [identity_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/identity/providers/identity_providers.dart)
- Remove `FlutterNativeSplash.remove()` from `AppLifecycleNotifier._init()` to delegate responsibility to the Flutter splash screen.

#### [MODIFY] [soteria_routes.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/navigation/soteria_routes.dart)
- Add `static const String splash = '/splash';`.

#### [MODIFY] [app_router.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/navigation/app_router.dart)
- Set `initialLocation: SoteriaRoutes.splash`.
- Add `GoRoute` for `SoteriaRoutes.splash`.
- Ensure redirects handle transitions from splash correctly.

### Preview & Testing

#### [NEW] [splash_preview.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/splash/preview/splash_preview.dart)
- Add splash screen previews for different states and device sizes.

#### [MODIFY] [startup_preview_page.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/preview_gallery/pages/startup_preview_page.dart)
- Integrate the new splash screen into the preview gallery.

#### [NEW] [splash_screen_test.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/test/features/splash/presentation/screens/splash_screen_test.dart)
- Add tests for rendering, asset usage, and responsiveness.

## Verification Plan

### Automated Tests
- Run `flutter test test/features/splash/presentation/screens/splash_screen_test.dart`.
- Run `flutter analyze`.

### Manual Verification
- Deploy to Android and iOS simulators/devices.
- Verify:
  - No white/black flash during handoff.
  - Seamless transition from native color (#090514) to Flutter splash.
  - Animation is smooth and premium.
  - Routing to Auth/Dashboard works correctly after splash.
  - Responsiveness on different screen sizes.
  - Reduced motion settings are respected.
