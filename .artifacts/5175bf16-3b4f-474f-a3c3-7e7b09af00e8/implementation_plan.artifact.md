# Implementation Plan - Competitive History, Personal Records & Season Analytics

Implement a comprehensive Competitive Career Profile system that allows players to view their long-term competitive journey, personal records, and detailed performance analytics.

## User Review Required

> [!IMPORTANT]
> The `CompetitiveCareerScreen` will serve as the primary hub for long-term progression. It will integrate existing `CompetitiveProfile` data but provide deeper insights like season comparisons and trend charts.
>
> [!NOTE]
> We will reuse the `PerformanceAnalyticsRepository` which currently lives in `lib/features/analytics`. We may need to ensure it's accessible or move it to a more shared location if needed, but for now, we'll keep it as is.

## Proposed Changes

### Domain & Data Layer

#### [MODIFY] [competitive_profile.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/competitive_profile.dart)
- Ensure all career summary metrics are easily accessible.

#### [NEW] [competitive_career_summary.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/competitive_career_summary.dart)
- A dedicated model for career-wide aggregation if `CompetitiveProfile` becomes too bloated.

#### [MODIFY] [competitive_statistics_service.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/services/competitive_statistics_service.dart)
- Add logic for best season identification and category performance insights.

---

### Presentation Layer - Widgets

#### [NEW] [season_comparison_card.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/career/season_comparison_card.dart)
- Visual comparison between two seasons.

#### [NEW] [season_trend_chart.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/career/season_trend_chart.dart)
- Simple line chart showing rank/RP progression over seasons.

#### [NEW] [category_performance_card.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/career/category_performance_card.dart)
- Displays performance by category (Math, Science, etc.).

#### [MODIFY] [career_summary_card.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/profile/career_summary_card.dart)
- Enhance with "Best Season" and "Career Best" highlights.

---

### Presentation Layer - Screens

#### [NEW] [competitive_career_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/competitive_career_screen.dart)
- The main premium career dashboard.

#### [NEW] [competitive_performance_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/competitive_performance_screen.dart)
- Detailed performance deep-dive (Accuracy, Win Rate, Categories).

#### [NEW] [season_history_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/season_history_screen.dart)
- Comprehensive list of past seasons with comparison tool.

---

### Providers & State

#### [NEW] [career_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/providers/career_providers.dart)
- Providers for career summary, season history, and performance data.

---

### Previews & Testing

#### [NEW] [competitive_career_previews.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/preview/competitive_career_previews.dart)
- Comprehensive previews for the new career system.

#### [NEW] [competitive_career_test.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/test/features/player/competitive_career_test.dart)
- Domain and UI tests for career aggregation and screens.

## Verification Plan

### Automated Tests
- `flutter test test/features/player/competitive_career_test.dart`
- `flutter test test/features/player/competitive_statistics_test.dart`

### Manual Verification
- Run the app in preview mode: `flutter run -t lib/main_preview.dart`.
- Verify the "Competitive Career" screen layout on different device sizes.
- Verify theme support (Dark/Premium Gold).
- Verify accessibility (Semantics, Large Text).
