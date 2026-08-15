# Story 10.7 Implementation Plan: Practice Session History & Personal Performance Tracking

This plan outlines the implementation of a persistent Practice History and Personal Performance layer for Soteria. It focuses on providing users with a clear record of their learning journey while maintaining a strict separation from competitive rankings.

## User Review Required

> [!IMPORTANT]
> The implementation uses `users/{userId}/practice_results/{resultId}` as the Firestore path, consistent with existing competitive result patterns.
> We are extending the existing `PracticeResult` model and introducing a `PracticeHistory` summary model for efficient UI display.

## Proposed Changes

---

### [Domain Layer]

Summary: Define the core models and repository interfaces for practice history and performance.

#### [MODIFY] [practice_result.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/practice/domain/models/practice_result.dart)
- Add `userId` field to `PracticeResult`.
- Add `resultId` field (can be same as `sessionId` or separate).

#### [NEW] [practice_history.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/practice/domain/models/practice_history.dart)
- Define `PracticeHistory` model:
    - `totalSessions`
    - `totalQuestions`
    - `totalCorrect`
    - `averageAccuracy`
    - `categoryPerformance` (Map of category ID to accuracy/count)
    - `difficultyPerformance` (Map of difficulty to accuracy/count)
    - `trends` (Accuracy over time)
    - `personalBests` (highest accuracy, most questions, etc.)

#### [NEW] [practice_result_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/practice/domain/repositories/practice_result_repository.dart)
- Define interface for recording and fetching practice results.

---

### [Data Layer]

Summary: Implement Firestore persistence and local caching for practice results.

#### [NEW] [firestore_practice_result_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/practice/data/repositories/firestore_practice_result_repository.dart)
- Implement `PracticeResultRepository` using Firestore.
- Path: `users/{userId}/practice_results/{resultId}`.
- Support pagination.

---

### [Presentation Layer]

Summary: Create the UI for viewing practice history and performance analytics.

#### [MODIFY] [practice_history_providers.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/practice/presentation/providers/practice_history_providers.dart)
- Implement `practiceHistoryProvider` to fetch and aggregate history into `PracticeHistory`.
- Implement `practiceHistoryListProvider` for the paginated list of sessions.

#### [NEW] [practice_history_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/practice/presentation/screens/practice_history_screen.dart)
- Main screen showing summary and session list.

#### [NEW] [practice_history_detail_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/practice/presentation/screens/practice_history_detail_screen.dart)
- Detailed view of a past practice session.

#### [NEW] [practice_performance_widgets.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/practice/presentation/widgets/history/practice_performance_widgets.dart)
- Reusable widgets for charts, category performance, and summary cards.

---

### [Verification Layer]

Summary: Ensure the implementation is correct and follows security/privacy rules.

#### [NEW] [practice_history_test.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/test/features/practice/domain/models/practice_history_test.dart)
- Unit tests for aggregation and trend calculation.

#### [NEW] [practice_result_repository_test.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/test/features/practice/data/repositories/practice_result_repository_test.dart)
- Repository tests.

## Verification Plan

### Automated Tests
- Run `flutter test` for new unit and repository tests.
- Run `flutter test integration_test` if applicable.

### Manual Verification
- Deploy to emulator/device.
- Complete several practice sessions.
- Verify history updates correctly.
- Verify pagination works.
- Verify category/difficulty performance reflects data correctly.
- Verify trends show "Improving", "Stable", or "Declining" correctly.
