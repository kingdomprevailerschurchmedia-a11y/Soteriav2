# Implementation Plan - Epic 10 Story 10.10: Pro Mode Results

Build the complete Pro Mode Results experience, transforming completed sessions into a premium, authoritative results experience with verified scoring, rewards, and detailed performance metrics.

## User Review Required

> [!IMPORTANT]
> - **Accuracy Calculation**: Accuracy will be calculated as `correctAnswers / (correctAnswers + wrongAnswers + timeouts)`. Skips are excluded from the denominator as per typical "answered" definitions, but timeouts are included.
> - **Premium Visuals**: The results screen uses Soteria Gold and Purple theme with specific animations for a premium feel.
> - **Authoritative Rewards**: Rewards (XP/Coins) are calculated server-side (simulated in repository) and tied to `sessionId` for idempotency.

## Proposed Changes

### [Gameplay Engine]

#### [MODIFY] [firestore_pro_mode_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart)
- Enhance `completeSession` to calculate:
    - `avgResponseTime`
    - `fastestAnswerTime`
    - `slowestAnswerTime`
- Refine accuracy calculation to be `correct / answered`.
- Ensure reward calculation is authoritative and based on the provided `GameState`.
- Verify idempotency check.

#### [MODIFY] [pro_mode_results_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/gameplay_engine/pages/pro_mode_results_screen.dart)
- Update UI to perfectly match the premium Soteria brand requirements.
- Wire up "Review Answers" to `CompetitiveReviewScreen`.
- Ensure animations respect `Reduced Motion` settings.
- Add accessibility semantics for metrics and rewards.

#### [MODIFY] [pro_mode_results_provider.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/gameplay_engine/providers/pro_mode_results_provider.dart)
- Ensure proper error handling and state management for session completion.

### [Previews & Tests]

#### [MODIFY] [pro_mode_results_previews.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/preview/pro_mode/pro_mode_results_previews.dart)
- Add comprehensive previews for different scenarios (Perfect, Average, Fail, Timeout, Rewards, Loading, Error).

#### [NEW] [pro_mode_results_logic_test.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/test/features/gameplay_engine/pro_mode_results_logic_test.dart)
- Unit tests for accuracy, scoring, and metric calculations in the repository.

#### [MODIFY] [pro_mode_results_screen_test.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/test/features/gameplay_engine/pro_mode_results_screen_test.dart)
- UI tests for the results screen components and animations.

## Verification Plan

### Automated Tests
- Run `flutter test test/features/gameplay_engine/pro_mode_results_logic_test.dart`
- Run `flutter test test/features/gameplay_engine/pro_mode_results_screen_test.dart`

### Manual Verification
- Use `lib/main_preview.dart` to view the `Pro Mode Results` preview gallery.
- Verify animations, responsive layout on different device sizes, and accessibility semantics.
