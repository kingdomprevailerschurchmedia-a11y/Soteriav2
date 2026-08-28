# Implementation Plan - Question Freshness Filter for Competitive Modes

This plan implements a "Freshness Filter" that prevents users from seeing recently answered questions in competitive modes (Pro, Versus, Tournament).

## Proposed Changes

### [Analytics Feature]

#### [MODIFY] [question_analytics_repository.dart](file:///C:/Joseph Project/Soteria/lib/features/analytics/domain/repositories/question_analytics_repository.dart)
- Add `Future<Set<String>> getRecentlyAnsweredIds(String userId, {Duration? within})` to the interface.

#### [MODIFY] [firestore_question_analytics_repository.dart](file:///C:/Joseph Project/Soteria/lib/features/analytics/data/repositories/firestore_question_analytics_repository.dart)
- Implement `getRecentlyAnsweredIds` by querying the `question_analytics_events` collection in Firestore.
- Default to fetching questions answered in the last 14 days if no duration is specified.

### [Auth/Lobby Feature]

#### [MODIFY] [pro_lobby_providers.dart](file:///C:/Joseph Project/Soteria/lib/features/dashboard/presentation/providers/pro_lobby_providers.dart)
- Update `startSession` to:
    1.  Fetch the user's `recentlyAnsweredIds` from the `QuestionAnalyticsRepository`.
    2.  Pass these IDs to the `QuestionSelectionRequest` under `excludedQuestionIds`.

### [Question Content Feature]

#### [MODIFY] [question_selection_service.dart](file:///C:/Joseph Project/Soteria/lib/features/question_content/domain/selection/question_selection_service.dart)
- Improve the pool building logic: If a significant number of `excludedQuestionIds` are provided, increase the fetch `limit` from Firestore to ensure a large enough pool is built before filtering.

## Verification Plan

### Manual Verification
- **Competitive Freshness:**
    1.  Complete a Pro Mode session with specific questions.
    2.  Immediately start another Pro Mode session in the same category/difficulty.
    3.  Verify that none of the questions from the previous session appear in the new one.
- **Filtering Logic:** Verify that the "Recently Answered" list is correctly limited by time (e.g., questions from a month ago can reappear, but questions from yesterday cannot).
- **Fallback Safety:** If a user has answered *all* available questions in a category, verify that the "Smart Fallback" logic in `QuestionSelectionService` still allows the game to start (likely by ignoring the filter if the pool becomes empty).
