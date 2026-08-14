# Implementation Plan - Competitive Seasons & Live Experience

Implement the complete live competitive season experience, allowing players to track their progress, view rewards, and compete on season-specific leaderboards.

## User Review Required

> [!IMPORTANT]
> The season dashboard acts as a central hub for the current competitive period. It integrates multiple existing systems (Rank, Leaderboard, Milestones, Rewards) into a single, cohesive experience.

- Navigation to this screen is added to the `SeasonHeader` on the main dashboard.
- Season transitions are handled reactively via Firestore streams.

## Proposed Changes

### Presentation Layer

#### [NEW] [competitive_season_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/screens/competitive_season_screen.dart)
- The main Season Dashboard.
- Features: Season Hero (Countdown), Your Standing (Rank/RP), Leaderboard Preview, Season Milestones, and Reward Preview.

#### [MODIFY] [season_header.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/widgets/season_header.dart)
- Add `onTap` to navigate to the new `CompetitiveSeasonScreen`.

#### [MODIFY] [reward_providers.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/providers/reward_providers.dart)
- Add `seasonRewardDefinitionsProvider` to fetch authoritative reward metadata for a given season.

---

### Navigation & Previews

#### [MODIFY] [soteria_routes.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/core/navigation/soteria_routes.dart)
- Add `/app/season` route constant.

#### [MODIFY] [app_router.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/core/navigation/app_router.dart)
- Register `CompetitiveSeasonScreen` route.

#### [NEW] [season_previews.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/preview/season_previews.dart)
- Add comprehensive previews for Active, Upcoming, Ending Soon, and Completed season states.

#### [MODIFY] [all_previews.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/preview/registry/all_previews.dart)
- Register the new season previews in the developer gallery.

## Verification Plan

### Automated Tests
- **UI Tests**: Update `test/features/player/season_ui_test.dart` to verify the new dashboard components and state handling.
- **Analysis**: Run `flutter analyze` to ensure no regressions.

### Manual Verification
- Launch Preview Gallery -> Gameplay -> Season Dashboard.
- Verify real-time countdown synchronization.
- Test navigation from Dashboard -> Season Header -> Season Dashboard -> Leaderboard.
- Check responsiveness on different screen sizes (Phone/Tablet).
