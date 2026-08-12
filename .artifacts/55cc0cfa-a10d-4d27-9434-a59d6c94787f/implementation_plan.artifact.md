# Implementation Plan - Competitive Match History & Performance Insights

Implement a premium match history experience that allows players to track their competitive journey, visualize performance trends, and gain meaningful insights using existing authoritative systems.

## User Review Required

> [!IMPORTANT]
> **Data Synchronization:** Quiz results are currently stored locally via `QuizLocalDataSource`. If a user switches devices, detailed match history (questions answered, accuracy per question) may be unavailable for historical matches unless we sync `QuizResult` to Firebase. For this epic, we will prioritize displaying what is available and handling missing data gracefully.

> [!NOTE]
> **Performance Insights:** Insights will be generated based on a minimum sample size of 5 matches to ensure statistical significance.

## Proposed Changes

### Domain Layer

#### [MODIFY] [CompetitiveStatisticsService](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/services/competitive_statistics_service.dart)
- Enhance `generateMatchInsights` to strictly enforce minimum sample sizes.
- Add more deterministic insights (e.g., "Your accuracy improved this season").

#### [NEW] [MatchHistoryRepositoryImpl](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/data/repositories/firebase_match_history_repository.dart)
- Implement the `MatchHistoryRepository` interface.
- Orchestrate `CompetitiveResultRepository`, `RankHistoryRepository`, and `QuizHistoryRepository` to build `CompetitiveMatch` objects.
- Implement efficient pagination and filtering.

#### [MODIFY] [FetchMatchHistoryUseCase](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/usecases/fetch_match_history_use_case.dart)
- Update to use the new `MatchHistoryRepository`.

---

### UI Layer

#### [MODIFY] [CompetitiveMatchHistoryScreen](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/competitive_match_history_screen.dart)
- Refine the layout to feel "premium" using Soteria design tokens.
- Improve the `PerformanceSummary` section.
- Integrate `PerformanceInsightSection` and `PerformanceTrendWidget`.

#### [MODIFY] [CompetitiveMatchHistoryCard](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/match_history/competitive_match_history_card.dart)
- Enhance visual language for Win/Loss/Draw/Invalidated states.
- Display Rank Points change and Score clearly.

#### [NEW] [CompetitiveMatchDetailsSheet](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/match_history/competitive_match_details_sheet.dart)
- A dedicated, detailed view of a single match.
- Show score, accuracy, questions, time, rank changes, and streak impact.

#### [MODIFY] [MatchHistoryFilterBar](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/match_history/match_history_filter_bar.dart)
- Ensure full support for Season, Mode, and Outcome filters.

---

### Preview & Testing

#### [NEW] [MatchHistoryFixtures](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/preview/match_history_fixtures.dart)
- Create deterministic fixtures for all states (Empty, Win, Loss, Trends, etc.).

#### [MODIFY] [MatchHistoryPreviews](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/preview/match_history_previews.dart)
- Update previews to include the refined UI and all edge cases.

#### [NEW] [MatchHistoryDomainTests](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/test/features/player/match_history_domain_test.dart)
- Test pagination, filtering, and trend calculation logic.

## Verification Plan

### Automated Tests
- `flutter test test/features/player/match_history_domain_test.dart`
- `flutter test test/features/player/competitive_history_ui_test.dart`
- `flutter test test/features/player/competitive_statistics_test.dart`

### Manual Verification
- Launch the preview gallery: `flutter run -t lib/main_preview.dart`
- Verify "Competitive Match History" gallery item.
- Check responsiveness on Small Phone, Tablet, and Landscape via previews.
- Verify accessibility (Large Text, Screen Reader semantics).
