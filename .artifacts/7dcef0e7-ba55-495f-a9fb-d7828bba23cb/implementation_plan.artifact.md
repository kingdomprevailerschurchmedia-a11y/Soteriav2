# Implementation Plan - Fix Post-Auth Navigation

Address the issue where the application stops after a successful sign-in by correcting the navigation redirect logic in `GoRouter`.

## User Review Required

> [!IMPORTANT]
> The navigation logic was previously only redirecting to the home screen if the user was on the **Splash Screen**. I will update this to redirect the user whenever the app reaches the `ready` state and the user is on any **Authentication** or **Splash** route.

## Proposed Changes

### Navigation Optimization

#### [MODIFY] [app_router.dart](file:///C:/Joseph%20Project/lib/core/navigation/app_router.dart)
- Update the `redirect` function to handle transitions from `/auth/...` and `/` to `/preview-gallery` (the current dashboard placeholder) once the `AppStartupState` becomes `ready`.

## Verification Plan

### Manual Verification
- Perform an email login.
- Verify that as soon as the keyboard closes and the login succeeds, the app navigates to the **Design System Preview Gallery**.
- Repeat for Google Sign-In.
- Verify that if the app is already in the `ready` state upon cold boot, it skips auth/onboarding and goes straight to the gallery.
