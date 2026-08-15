# Pro Mode Results Architecture

This document describes the implementation of the results experience for Pro Mode sessions in Soteria.

## Overview
The Pro Mode Results system provides a premium, authoritative summary of a player's performance in a competitive Pro Mode session. It handles scoring, XP calculation, coin rewards, and persistence with a focus on competitive integrity.

## Result Architecture
Pro Mode results are derived from the completed `GameState` and validated authoritatively in the `ProModeRepository`.

### Result Model
The `ProModeResult` model extends `GameResult` to include Pro-specific metrics:
- `rating`: A performance grade (S, A, B, C, D) based on accuracy.
- `avgResponseTime`: Average time taken per question.
- `fastestAnswerTime`: Fastest correct answer time.
- `slowestAnswerTime`: Slowest correct answer time.
- `rewards`: Authoritative `RewardSummary` containing base and bonus XP/coins.

### Score Calculation
Reuses the established scoring architecture from the `GameplayEngine`. The final score is captured in the `GameState` during play and persisted in the `ProModeResult`.

### Accuracy Calculation
Calculated as `correctAnswers / totalQuestions`. 
- Perfect accuracy (1.0) grants a "Perfect Score" bonus.
- Handles zero-question scenarios to avoid division by zero.

### Timing Metrics
Calculated from the `AnswerResult` history in the `GameState`:
- `avgResponseTime`: `sum(responseTime) / answeredQuestions`
- `fastestAnswerTime`: `min(responseTime)`
- `slowestAnswerTime`: `max(responseTime)`

## Authoritative Session Completion
Sessions are completed via `ProModeRepository.completeSession(sessionId, finalState)`.

### Atomic Rewards
Rewards are granted within a Firestore transaction:
1. Deduct entry fee (handled at session start).
2. Validate session existence and status.
3. Check for existing result (Idempotency).
4. Update session status to `completed`.
5. Persist the `ProModeResult`.
6. Increment player `xp` and `coins` balances.

### Reward Idempotency
Using the `sessionId` as the document ID for the `pro_results` collection ensures that rewards are only granted once. If a completion request is retried, the transaction will detect the existing result and skip reward incrementing.

## UI / UX
The `ProModeResultsScreen` provides a high-fidelity achievement moment.

### Premium Visuals
- Gold highlights for achievement emphasis.
- Soteria Purple design system.
- Scaled performance rating reveal.
- Fade-in and slide-up animations.

### Accessibility
- **Screen Readers**: Semantic labels for all metrics and ratings.
- **Reduced Motion**: All animations respect `MediaQuery.of(context).disableAnimations` and provide instant state transitions when disabled.

### Question Review
A dedicated `ProModeQuestionReviewScreen` allows players to review their performance:
- Shows question text, user answer, correct answer, and explanation.
- Maps session data to `CompetitiveReviewItem`s.
- Validates access by fetching the authoritative result for the session.

## Navigation Flow
1. **Lobby**: Configure and start session.
2. **Gameplay**: Complete questions.
3. **Results**: View summary and rewards.
4. **Review**: Analyze specific answers.
5. **Replay**: Return to lobby to start a NEW session (with a new fee).

## Offline & Error Handling
- **Pending Sync**: If a session completes while offline, a sync pending banner is shown.
- **Authoritative Failure**: If validation fails, an error state allows retry.
- **Loading State**: A "VERIFYING PERFORMANCE..." loader ensures the user waits for authoritative confirmation.

## Security
- **User Isolation**: Firestore rules (and repository logic) ensure users can only access their own results.
- **Integrity**: Score and rewards are calculated repository-side based on the authoritative answer history.
- **Anti-Cheat**: Entry fees are deducted BEFORE gameplay starts; rewards are only granted for completed sessions.
