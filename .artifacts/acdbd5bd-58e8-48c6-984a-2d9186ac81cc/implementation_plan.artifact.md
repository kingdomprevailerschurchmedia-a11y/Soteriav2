# Implementation Plan - Fix Startup Dashboard Flash

Eliminate the visual flash of the Dashboard during app startup by tightening the routing logic and ensuring the application state authoritative resolution precedes any production screen rendering.

## Root Cause
The `GoRouter` redirect logic allowed the current location (which could be `/app` due to state restoration or deep linking) to persist while the `AppStartupState` was still `loading`. Because the `loading` redirect returned `null`, the router proceeded to build the matched Dashboard route before the onboarding/auth state was fully resolved.

## Proposed Changes

### Core Navigation

#### [MODIFY] [app_router.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/navigation/app_router.dart)
- Tighten the `redirect` logic:
  - If `lifecycle == AppStartupState.loading`, explicitly return `SoteriaRoutes.splash` unless already there. This prevents restoration/deep-links from bypassing the splash.
  - Prioritize `AppStartupState` guards over the current location until `AppStartupState.ready` is reached.
  - Ensure that the Dashboard route is inaccessible until the state is explicitly `ready`.

### Lifecycle Management

#### [MODIFY] [identity_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/identity/providers/identity_providers.dart)
- Ensure `AppStartupState` transitions are authoritative and do not skip intermediate validation (like onboarding check).

### Verification & Testing

#### [NEW] [startup_flash_test.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/test/core/navigation/startup_flash_test.dart)
- Add a widget test that simulates:
  - A restored location of `/app`.
  - An initial `AppStartupState.loading`.
  - Verifies that the `DashboardScreen` is **not** built/instantiated during the loading phase.

#### [NEW] [slow_startup_test.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/test/helpers/slow_startup_test.dart)
- Helper to simulate delayed auth/onboarding resolution for manual visual verification.

## Verification Plan

### Automated Tests
- Run `flutter test test/core/navigation/startup_flash_test.dart`.
- Run `flutter analyze`.

### Manual Verification
- **Cold Start (New User)**: Verify Native Splash -> Splash Screen -> Onboarding (Zero Dashboard flash).
- **Cold Start (Returning User)**: Verify Native Splash -> Splash Screen -> Dashboard.
- **Deep Link / Restoration**: Launch app while targeting `/app` but without being onboarded; verify it stays on Splash/Onboarding.
- **Slow Network/Auth**: Simulate a 5-second auth delay; verify the Splash Screen remains visible and Dashboard is never rendered.
