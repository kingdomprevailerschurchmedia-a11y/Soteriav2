# Soteria Navigation Foundation & Route Architecture Implementation Plan (Story 1.6)

This plan establishes a scalable, typed, and modular navigation architecture for Soteria using `GoRouter`. It focuses on separation of concerns, global navigation control via a service, and premium motion transitions.

## Proposed Changes

### 1. Route Definitions & Constants
Create a structured system for route names and paths to avoid hardcoded strings.
- **[NEW] `lib/core/navigation/soteria_routes.dart`**: Define route constants using a `sealed class` or nested static classes organized by module (Foundation, Auth, Main App, etc.).
- **[NEW] `lib/core/navigation/route_params.dart`**: Models for complex route parameters.

### 2. Navigation Service
Implement a global service to decouple widgets from the `GoRouter` context where necessary.
- **[NEW] `lib/core/navigation/navigation_service.dart`**: A Riverpod-based service wrapping `GoRouter` actions (`push`, `go`, `replace`, `pop`, `showDialog`, `showBottomSheet`).

### 3. Modular Route Architecture
Reorganize `lib/core/navigation/app_router.dart` to support modular route definitions.
- **[MODIFY] `AppRouter`**:
    - Implement `ShellRoute` for the main app navigation (future).
    - Configure `redirect` for global guards (Auth, Guest, Onboarding).
    - Set up `errorBuilder` for unknown route handling with a premium error UI.
    - Enable `debugLogDiagnostics` for development.

### 4. Route Guards (Abstractions)
- **[NEW] `lib/core/navigation/guards/`**:
    - `BaseGuard`: Interface for all route guards.
    - Implement abstract guards: `AuthGuard`, `GuestGuard`, `PremiumGuard`, `OnboardingGuard`.
    - These will initially return `null` (no redirect) but provide the hook for future business logic.

### 5. Premium Transitions
- **[NEW] `lib/core/navigation/transitions/soteria_page_transitions.dart`**:
    - Factory for `CustomTransitionPage`.
    - Support for: `Fade`, `Scale`, `Slide`, `Blur`, and `SharedAxis`.
    - Global duration tokens (250-350ms).

### 6. Error & Deep Linking
- **[NEW] `lib/features/error_routing/unknown_route_screen.dart`**: A premium "404" style screen.
- **Preparation for Deep Linking**: Configure `GoRouter` with `configuration` and `initialLocation` handling ready for App Links/Universal Links.

### 7. Developer Preview Gallery Expansion
- **[NEW] `lib/features/preview_gallery/pages/navigation_foundation_page.dart`**:
    - Route List visualization.
    - Transition testing area (Buttons to trigger different transitions).
    - Guard state simulation.

## Verification Plan

### Automated Tests
- **Navigation Tests**: Verify pushing/popping routes via `NavigationService`.
- **Route Guard Tests**: Verify redirects trigger when state changes (using mocked providers).
- **Unknown Route Test**: Attempt to navigate to a random path and verify the Error Screen is shown.

### Manual Verification
- Verify browser URL updates (if testing in web-enabled mode).
- Check transition smoothness on device.
- Verify state restoration after app suspension.
