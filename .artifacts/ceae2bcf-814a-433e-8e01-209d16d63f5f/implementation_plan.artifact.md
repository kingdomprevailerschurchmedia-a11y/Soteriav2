# Story 10.10 — PRO MODE RESULTS Implementation Plan

This plan outlines the completion of the Pro Mode Results experience, ensuring authoritative validation, premium UI, and full lifecycle integration.

## User Review Required

> [!IMPORTANT]
> The implementation relies on the existing `FirestoreProModeRepository` and `ProModeResult` models. I will be refining the authoritative calculation logic in the repository to include advanced timing metrics (fastest, slowest, average).

## Proposed Changes

### Domain & Data Layer

#### [MODIFY] [firestore_pro_mode_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart)
- Update `completeSession` to calculate:
    - `avgResponseTime`
    - `fastestAnswerTime`
    - `slowestAnswerTime`
- Ensure reward logic is strictly authoritative and uses the `sessionId` for idempotency.
- Ensure `skippedQuestions` are calculated correctly (Total - Answered).

### UI Layer

#### [MODIFY] [pro_mode_results_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/pages/pro_mode_results_screen.dart)
- Implement `REVIEW ANSWERS` navigation:
    - Map `ProModeResult.answers` and `GameState.questions` to `CompetitiveReviewItem`s.
    - Navigate to `CompetitiveReviewScreen`.
- Refine `PLAY AGAIN` to ensure it triggers a fresh session flow (returning to lobby or triggering new session creation).
- Add semantic labels for accessibility (Screen Readers).
- Ensure animations respect `Reduced Motion`.

#### [MODIFY] [soteria_routes.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/navigation/soteria_routes.dart)
- Ensure Pro Mode Results route is correctly defined and supports both `GameState` (post-game) and `sessionId` (history) loading.

### Previews & Documentation

#### [MODIFY] [pro_mode_results_previews.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/preview/pro_mode/pro_mode_results_previews.dart)
- Update previews to include all requested states (Excellent, Average, Low, Perfect, Timeout, Reward Earned/Pending, etc.).

#### [MODIFY] [pro_mode_results.md](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/docs/pro_mode_results.md)
- Update documentation with final architecture and metrics.

## Verification Plan

### Automated Tests
- **Unit Tests**:
    - `FirestoreProModeRepository` test: Verify timing metrics calculation (fastest/slowest/avg).
    - `ProModeResult` test: Verify rating calculation logic.
- **Integration Tests**:
    - Full flow from Gameplay -> Completion -> Results -> Review.
    - Verify idempotency by calling `completeSession` twice.

### Manual Verification
- Run Previews to verify UI layout and animations.
- Test with Accessibility Inspector to verify semantic labels.
- Test with "Reduced Motion" enabled in system settings.
