# Implementation Plan - Epic 4 Story 4.3: Dashboard Actions, Navigation & Interaction Layer

Transform the Home Dashboard into a fully interactive navigation hub using GoRouter, premium transitions, and a robust interaction layer.

## User Review Required

> [!IMPORTANT]
> **Stateful Navigation**: I will refactor the `HomeShell` to use `StatefulShellRoute` (specifically `StatefulNavigationShell`). This will allow preserving the scroll position and state of each tab (Home, Play, Leaderboard, etc.) when switching between them, which is a key requirement.

> [!TIP]
> **Coming Soon Strategy**: For features not yet implemented (Practice, Pro Mode, Versus, Tournament, etc.), I will create a reusable `ComingSoonScreen` that provides a premium placeholder experience instead of dead buttons.

## Proposed Changes

### Core & Navigation Foundation

#### [NEW] [app_destination.dart](file:///C:/Joseph%20Project/lib/core/navigation/models/app_destination.dart)
- Define `AppDestination` model with route name, path, icon, and requirements (auth, feature flag).

#### [NEW] [navigation_coordinator.dart](file:///C:/Joseph%20Project/lib/core/navigation/services/navigation_coordinator.dart)
- Centralized service to handle navigation logic, analytics logging, and routing events.

#### [MODIFY] [app_router.dart](file:///C:/Joseph%20Project/lib/core/navigation/app_router.dart)
- Upgrade `ShellRoute` to `StatefulShellRoute`.
- Implement centralized route definitions with premium transitions.
- Add guards and feature flag checks.

---

### UI Components & Screens

#### [NEW] [coming_soon_screen.dart](file:///C:/Joseph%20Project/lib/shared/screens/coming_soon_screen.dart)
- Reusable premium placeholder for future features.
- Supports different categories (Game, Social, Finance) with unique illustrations/text.

#### [NEW] [soteria_page.dart](file:///C:/Joseph%20Project/lib/shared/widgets/soteria_page.dart)
- Base wrapper for all screens to handle Success/Loading/Offline/Error states consistently.

#### [MODIFY] [home_shell.dart](file:///C:/Joseph%20Project/lib/features/dashboard/presentation/screens/home_shell.dart)
- Refactor to support `StatefulNavigationShell`.
- Improve bottom nav interaction and state preservation.

#### [MODIFY] [dashboard_header.dart](file:///C:/Joseph%20Project/lib/features/dashboard/presentation/widgets/dashboard_header.dart)
- Add Settings and Notification buttons with navigation triggers.

#### [MODIFY] [quick_actions_grid.dart](file:///C:/Joseph%20Project/lib/features/dashboard/presentation/widgets/quick_actions_grid.dart)
- Link buttons to routes via `NavigationCoordinator`.
- Add haptic feedback.

---

### Infrastructure & Performance

#### [NEW] [navigation_providers.dart](file:///C:/Joseph%20Project/lib/core/navigation/providers/navigation_providers.dart)
- Riverpod providers for `NavigationCoordinator` and route state.

## Verification Plan

### Automated Tests
- **Navigation Tests**: Verify all dashboard buttons navigate to the expected path.
- **GoRouter Tests**: Ensure auth guards and deep links work correctly.
- **Widget Tests**: `ComingSoonScreen` rendering and back button functionality.
- **Accessibility Tests**: Verify semantic labels for all navigation buttons.

### Manual Verification
- **Tab Switching**: Verify scroll position is preserved when switching between Home and Leaderboard.
- **Haptics**: Feel the tactile feedback when tapping quick actions and bottom nav items.
- **Transitions**: Confirm smooth fade/slide transitions between screens.
- **Offline Indicator**: Verify `SoteriaPage` shows the offline banner when connectivity is lost.
