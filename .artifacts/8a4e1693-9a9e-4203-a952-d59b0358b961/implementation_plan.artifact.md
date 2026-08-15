# Story 11.8 — Player Profile & Competitive Identity

Implement a unified **Player Profile & Competitive Identity** experience by consolidating all progression, engagement, and competitive systems into a single authoritative presentation layer.

## User Review Required

> [!IMPORTANT]
> The profile will serve as a **consumer and presentation layer**. No new sources of truth will be created. Authorized progression state (XP, Level, Rank, Streaks) will be pulled directly from their respective certified systems.

> [!WARNING]
> Existing redundant fields in `PlayerProfile` (level, xp, streaks) will be treated as display-only/stale in the UI, with the `PlayerProgression` and `CompetitiveStreak` systems serving as the authoritative sources.

## Proposed Changes

### [Component Name] Player Feature

#### [MODIFY] [competitive_profile.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/competitive_profile.dart)
Add `CompetitiveStreak` to the `CompetitiveProfile` model to integrate engagement data.

#### [MODIFY] [competitive_profile_provider.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/providers/competitive_profile_provider.dart)
Update the provider to watch the authoritative streak provider and include it in the aggregated `CompetitiveProfile`.

#### [MODIFY] [player_profile_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/player_profile_screen.dart)
Overhaul the screen to consume `competitiveProfileProvider` and implement the unified profile structure:
*   **Player Identity**: Avatar, Display Name, Username/Title.
*   **Competitive Identity**: Rank Badge, Level, XP Progress, Rank Progress.
*   **Engagement**: Current & Longest Streaks.
*   **Achievements**: Recent/Featured summary.
*   **Milestones**: Next milestone progress.
*   **Competitive Statistics**: Win rate, matches, season history.

#### [NEW] [engagement_summary_section.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/profile/engagement_summary_section.dart)
New widget to display streak information clearly.

#### [NEW] [career_statistics_section.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/profile/career_statistics_section.dart)
New widget to display aggregated statistics (wins, win rate, etc.) from `CompetitiveCareerSummary`.

#### [MODIFY] [competitive_profile_previews.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/preview/competitive_profile_previews.dart)
Update previews to cover all requested states (new player, high-level, offline, etc.).

## Verification Plan

### Automated Tests
*   `flutter test test/features/player/competitive_profile_provider_test.dart`
*   `flutter test test/features/player/competitive_profile_ui_test.dart`
*   Verify composition logic in unit tests: `PlayerIdentity + Progression + Rank + Achievements + Streaks`.

### Manual Verification
*   Deploy to Emulator and verify UI layout across different screen sizes.
*   Use Developer Preview to verify "empty" vs "full" profile states.
*   Verify accessibility labels using screen reader/semantics inspector.
*   Check offline behavior by disabling network and verifying cached data display.
