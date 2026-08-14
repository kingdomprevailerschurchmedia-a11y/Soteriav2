# Implementation Plan - Competitive Invitations, Rematches & Quick Match Actions

Streamline the transition from discovery to competition by implementing a context-aware invitation and rematch system.

## User Review Required

> [!IMPORTANT]
> - Recent opponents are derived from the last 10 unique completed matches in the player's match history.
> - "Rematch" actions will redirect to the challenge creation screen to allow for configuration (Category, Difficulty) before sending the invitation.
> - Blocked users are strictly excluded from all competitive interactions.

## Proposed Changes

### Domain & Data Layer

#### [MODIFY] [match_history_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/providers/match_history_providers.dart)
- Implement `recentOpponentsProvider` and `isRecentOpponentProvider`.

### Presentation & UI Components

#### [NEW] [competitive_quick_actions.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/presence/competitive_quick_actions.dart)
- Unified component for contextual actions (Challenge, Rematch, Accept, etc.).

#### [NEW] [recent_opponents_section.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/presence/recent_opponents_section.dart)
- Horizontal quick-scroll section for the dashboard.

#### [NEW] [challenge_status_badge.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/challenge/challenge_status_badge.dart)
- Small visual indicators for lifecycle states.

### Screen Enhancements

#### [MODIFY] [public_competitive_profile_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/public_competitive_profile_screen.dart)
- Integrate presence indicators and the quick action framework.

#### [MODIFY] [dashboard_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/screens/dashboard_screen.dart)
- Add `RecentOpponentsSection`.

### Navigation & Routing

#### [MODIFY] [app_router.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/navigation/app_router.dart)
- Register routes for `CreateChallengeScreen` and `PublicCompetitiveProfileScreen`.

## Verification Plan

### Automated Tests
- **Logic Tests**: Verify rematch eligibility based on match history.
- **Privacy Tests**: Ensure blocked users cannot be challenged.

### Manual Verification
- **Quick Actions**: Test all states of `CompetitiveQuickActions` (Online vs In Match, Friend vs Stranger).
- **Rematch Flow**: Complete a match and verify the opponent appears in the "Recent Opponents" section.
- **Responsive UI**: Verify `RecentOpponentCard` on small and large screens.
