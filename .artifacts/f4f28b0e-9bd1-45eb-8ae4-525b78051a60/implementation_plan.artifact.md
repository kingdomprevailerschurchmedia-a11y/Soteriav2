# Implementation Plan: Fix Goal Evaluation and Real-Time Rewards

This plan addresses the issue where practice sessions (like "Training Day") are not counted towards user goals and ensures rewards are granted in real-time upon goal completion.

## User Review Required

> [!IMPORTANT]
> The current implementation relies on the `CompetitiveGoalsScreen` being active to trigger goal evaluation. To make this truly global (real-time across all screens), I will update the logic to be more reactive, but the full "Global Orchestration" might require watching these providers in the main app entry point.

## Proposed Changes

### Goal Evaluation Logic
#### [MODIFY] [goal_evaluation_service.dart](file:///C:/Joseph Project/Soteria/lib/features/player/domain/services/goal_evaluation_service.dart)
- Update `evaluate` signature to include `List<PracticeResult> practiceResults`.
- Update `_calculateProgress` to merge data from both `QuizResult` and `PracticeResult` histories.
- Fix `GoalCategory.practiceCount` to correctly count sessions from `practiceResults`.
- Ensure `GoalCategory.xpEarned` and `GoalCategory.correctAnswers` aggregate values from both competitive and practice sessions.

### Goal Providers & Orchestration
#### [MODIFY] [goal_providers.dart](file:///C:/Joseph Project/Soteria/lib/features/player/presentation/providers/goal_providers.dart)
- Add dependency on `practiceHistoryListProvider`.
- Update `goalEvaluationProvider` to watch practice history.
- Integrate reward granting logic: when a goal is updated to `GoalStatus.completed`, automatically trigger XP/Coin rewards using `ProgressionRewardService`.
- Wire up `walletRepositoryProvider` and `applyXpTransactionProvider` to perform the actual credit operations.

### Reward Service Enhancements
#### [MODIFY] [progression_reward_service.dart](file:///C:/Joseph Project/Soteria/lib/features/player/domain/services/progression_reward_service.dart)
- Update `processGoalReward` to handle `RewardType.coins`.
- Ensure definition ID resolution is robust for dynamic daily/weekly goal IDs.

## Verification Plan

### Automated Tests
- Create a test case in `goal_evaluation_service_test.dart` (or verify existing) that covers `practiceCount` with valid `PracticeResult` data.
- Verify reward granting logic by mock-watching the repository calls when a goal transitions to completed.

### Manual Verification
- Complete a practice session and verify that the "Training Day" goal progress updates to 100%.
- Verify that XP/Coins are added to the user profile immediately after goal completion without requiring a manual "claim" (unless UI requires it).
