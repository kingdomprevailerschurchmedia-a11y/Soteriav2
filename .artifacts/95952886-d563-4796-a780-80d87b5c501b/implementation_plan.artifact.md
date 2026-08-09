# Implementation Plan - Story 8.6: Scoring Engine, XP & Reward System

This plan details the implementation of a production-grade scoring and reward system for the Soteria Quiz Engine. It extends the existing quiz architecture to include deterministic scoring, speed bonuses, streaks, and XP calculation.

## User Review Required

> [!IMPORTANT]
> The scoring logic will be implemented as a domain-level service (`QuizScoringEngine`) to ensure it is decoupled from the UI and testable in isolation.
> Idempotency will be handled at the `QuizController` level to prevent duplicate scoring of the same question.

## Proposed Changes

### Domain Layer

#### [NEW] [score_result.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/quiz/domain/models/score_result.dart)
Define an immutable model to represent the breakdown of a single question's score and XP.
- `baseScore`: Points from correctness.
- `speedBonus`: Points for quick response.
- `difficultyBonus`: Points from difficulty multiplier.
- `streakBonus`: Points from current streak.
- `totalScore`: Sum of all bonuses.
- `xpEarned`: Calculated XP.
- `coinsEarned`: Calculated coins (ready for future economy).

#### [NEW] [scoring_configuration.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/quiz/domain/models/scoring_configuration.dart)
A configuration class for scoring rules, avoiding hardcoded magic numbers.
- `difficultyMultipliers`: Map of `Difficulty` to `double`.
- `streakBonusMultiplier`: `double` (e.g., 0.1 for 10% per streak).
- `maxStreakBonus`: `double` (cap for streak bonus).
- `speedBonusThresholds`: Rules for speed bonuses.

#### [NEW] [reward_event.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/quiz/domain/models/reward_event.dart)
Domain events for the reward system.
- `QuestionReward`: Event emitted for each question.
- `QuizCompletionReward`: Event emitted at the end of a quiz.

#### [NEW] [quiz_scoring_engine.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/quiz/domain/services/quiz_scoring_engine.dart)
The core logic for all calculations.
- Deterministic formulas for score and XP.
- Support for Correct, Incorrect, Skipped, and Timed Out results.
- Speed bonus calculation based on `estimatedTime` vs `responseTime`.

### Presentation Layer

#### [MODIFY] [quiz_state.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/quiz/presentation/states/quiz_state.dart)
Extend `QuizState` to track:
- `xp`: Total XP earned in session.
- `bestStreak`: Max streak achieved.
- `lastScoreResult`: For UI feedback (animations).

#### [MODIFY] [quiz_controller.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/quiz/presentation/controllers/quiz_controller.dart)
- Integrate `QuizScoringEngine`.
- Update `selectAnswer`, `_handleTimeout`, and `skipQuestion` to calculate and apply rewards.
- Implement idempotency check using `currentIndex` to prevent double-scoring.

#### [MODIFY] [quiz_stats_bar.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/quiz/presentation/widgets/quiz_stats_bar.dart)
- Display current `score` and `xp` (using design tokens).
- Add support for `bestStreak` tracking.

#### [NEW] [score_gain_animation.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/quiz/presentation/widgets/score_gain_animation.dart)
- A subtle floating animation to show points and XP gained after an answer.

### Preview & Verification

#### [MODIFY] [gameplay_previews.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/quiz/preview/gameplay_previews.dart)
- Add scenarios for high scores, streaks, and different difficulties.

## Verification Plan

### Automated Tests
- **Unit Tests**: `test/features/quiz/quiz_scoring_engine_test.dart`
    - Verify all scoring formulas (Correct + Fast, Incorrect, Timeout, etc.).
    - Verify streak reset and multipliers.
    - Verify idempotency.
- **Widget Tests**: `test/features/quiz/quiz_stats_bar_test.dart`
    - Verify score and XP display updates.

### Manual Verification
- Run `main_preview.dart` and verify the new scoring UI components.
- Perform a live quiz run to ensure score/XP/streak update correctly and animations trigger.
