# Implementation Plan - Competitive Leaderboard Insights & Rank Movement

Improve the leaderboard experience by helping players understand their position, movement, and neighborhood.

## User Review Required

> [!IMPORTANT]
> This feature relies on authoritative leaderboard snapshots for position movement. We will introduce a `RankMovementEvent` to track these changes over time. Percentile calculations and "Distance to next" metrics will be derived from existing leaderboard data.

- Calculation for movement: `Previous Position - Current Position`. (Lower numeric position is better).
- Percentile formula: `(Position / Total Players) * 100`.

## Proposed Changes

### Domain Layer

#### [NEW] [rank_movement_event.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/rank_movement_event.dart)
Defines the `RankMovementEvent` model.
Fields: `id`, `userId`, `seasonId`, `previousPosition`, `currentPosition`, `positionDelta`, `timestamp`, `eventType`.

#### [MODIFY] [leaderboard_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/repositories/leaderboard_repository.dart)
Add methods:
- `Future<int> getTotalPlayers(String? seasonId)`
- `Future<List<RankMovementEvent>> getPositionHistory(String userId, String? seasonId)`
- `Future<void> recordMovement(RankMovementEvent event)`

#### [NEW] [leaderboard_insights_service.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/services/leaderboard_insights_service.dart)
Service to generate deterministic insights:
- Percentile calculation.
- Distance to next rank/player.
- Movement direction and magnitude.

---

### Data Layer

#### [MODIFY] [firebase_leaderboard_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/data/repositories/firebase_leaderboard_repository.dart)
Implement new methods using Firestore counters or aggregation queries for total players.

---

### Presentation Layer (Riverpod)

#### [MODIFY] [leaderboard_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/providers/leaderboard_providers.dart)
Add providers:
- `leaderboardTotalPlayersProvider`
- `leaderboardNeighborhoodProvider`
- `rankMovementHistoryProvider`
- `leaderboardInsightsProvider`

---

### UI Layer

#### [NEW] [rank_movement_indicator.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/leaderboard/rank_movement_indicator.dart)
Compact widget showing ↑, ↓, or — with delta magnitude.

#### [NEW] [player_leaderboard_position_card.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/leaderboard/player_leaderboard_position_card.dart)
Expanded card for "YOUR POSITION" section.

#### [NEW] [leaderboard_neighborhood.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/leaderboard/leaderboard_neighborhood.dart)
Displays the player immediately above and below the current user.

#### [NEW] [rank_progress_card.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/leaderboard/rank_progress_card.dart)
Shows progress toward the next rank tier.

#### [MODIFY] [leaderboard_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/leaderboard_screen.dart)
Integrate new sections above the main leaderboard list.

---

## Verification Plan

### Automated Tests
- `domain_tests`: Delta calculations, percentile formula, tie-break rules.
- `ui_tests`: Golden tests for movement indicators and neighborhood views.
- `integration_tests`: Verifying movement history persistence and isolation.

### Manual Verification
- Verify correct movement indicator after a rank update.
- Check "Distance to next" RP values match actual leaderboard entries.
- Test responsive layout on different screen sizes (Portrait/Landscape).
