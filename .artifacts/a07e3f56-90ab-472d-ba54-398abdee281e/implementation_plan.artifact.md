# Implementation Plan — Story 7.6: Logout & Session Management

Implement a secure, production-ready Logout & Session Management system that integrates with the existing Soteria architecture.

## User Review Required

> [!IMPORTANT]
> **Provider Invalidation**: On logout, I will explicitly invalidate `profileProvider`, `sessionProvider`, and `dashboardProvider`. Unrelated system providers (like `configurationProvider`) will remain untouched to maintain app stability.
> **Navigation Reset**: The logout flow will use `GoRouter.go()` to reset the navigation stack to the Auth Landing page, ensuring the back button cannot return to authenticated screens.

## Proposed Changes

### [Authentication & Session]

#### [NEW] [logout_notifier.dart](file:///C:/Joseph%20Project/lib/features/auth/presentation/providers/logout_notifier.dart)
A `StateNotifier` that orchestrates the logout sequence:
1.  Calls `LogoutUseCase`.
2.  Invalidates relevant Riverpod providers.
3.  Resets the `AppLifecycleProvider` to `auth` state if necessary.

#### [MODIFY] [identity_providers.dart](file:///C:/Joseph%20Project/lib/core/identity/providers/identity_providers.dart)
Ensure `SessionNotifier` and `AppLifecycleNotifier` react correctly to the `signOut` event from Firebase.

### [UI Components]

#### [NEW] [logout_confirmation_dialog.dart](file:///C:/Joseph%20Project/lib/features/auth/presentation/widgets/logout_confirmation_dialog.dart)
A premium glassmorphism dialog following the Soteria Design System.

#### [NEW] [player_profile_screen.dart](file:///C:/Joseph%20Project/lib/features/player/presentation/screens/player_profile_screen.dart)
A comprehensive profile screen with:
-   Account Section (Personal info, Security).
-   Preferences (Notifications, Theme).
-   Support (Help, About).
-   Destructive "Log Out" action at the bottom.

#### [MODIFY] [app_router.dart](file:///C:/Joseph%20Project/lib/core/navigation/app_router.dart)
Replace the placeholder profile route with `PlayerProfileScreen`.

### [Developer Preview System]

#### [MODIFY] [all_previews.dart](file:///C:/Joseph%20Project/lib/preview/registry/all_previews.dart)
Register the new Profile Screen and Logout Dialog previews.

## Verification Plan

### Automated Tests
-   **Unit Tests**: Verify `LogoutNotifier` invalidates correct providers.
-   **Integration Tests**: Verify navigation redirection after successful sign-out.

### Manual Verification
1.  Open Profile -> Tap Logout -> Confirm.
2.  Verify redirection to Auth Landing.
3.  Verify back button is disabled/ignored.
4.  Test both Email and Google sign-out flows in the Preview System.
5.  Check layout responsiveness on Tablet and Landscape.
