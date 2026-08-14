# Practice Results, Progression & Learning Feedback

This document describes the implementation of the Practice Mode results system, which provides detailed performance analytics and learning feedback.

## Architecture

The system follows a pure functional approach for result calculation, integrated with Riverpod for state management and the canonical Gameplay Engine for session tracking.

### Learning Loop
1. **SELECT**: User configures practice in the lobby.
2. **PRACTICE**: Question selection and loading.
3. **ANSWER**: Active gameplay with immediate feedback.
4. **LEARN**: Question review and explanations.
5. **RESULT**: Final performance summary.
6. **PROGRESSION**: XP and achievement integration.

## Models

### PracticeResult
Represents the immutable snapshot of a completed practice session.
- `sessionId`: Unique identifier for idempotency.
- `accuracy`: `correct / (correct + incorrect)`. Skipped questions are excluded from accuracy by default.
- `categoryPerformance`: Breakdown of total/correct per category.
- `difficultyPerformance`: Accuracy per difficulty level.
- `reviewItems`: Snapshot of question content and user response for offline review.
- `metadata`: Contains detected strengths and weaknesses.

### QuestionReviewItem
Stores enough information to display a complete review without refetching questions.
- Includes `questionText`, `selectedOptionIds`, `correctOptionIds`, and `explanation`.

## Logic & Rules

### Performance Messages
Deterministic messages based on accuracy:
- `>= 95%`: Exceptional! Mastery achieved.
- `>= 85%`: Excellent work!
- `>= 70%`: Great job!
- `>= 50%`: Good progress.
- `< 50%`: Keep practicing!

### Strength/Weakness Detection
Threshold-based detection to ensure statistical significance:
- **Strength**: Category accuracy `>= 80%` with at least 3 questions.
- **Weakness**: Category accuracy `< 60%` with at least 3 questions.

### Progression Integration
- **XP**: Awards XP based on `PracticeProgressionPolicy` (10 XP per correct answer, 10 XP completion bonus).
- **Idempotency**: `ProgressSnapshot` tracks `lastProcessedSessionId` to prevent duplicate rewards on screen rebuilds or navigation.

## UI / UX
- **Premium Design**: Uses glassmorphism and subtle gold accents for a focused learning experience.
- **Sequential Review**: Questions are displayed in an expandable list with color-coded status.
- **Responsive**: Adapts from small phones (320px) to tablets (1024px+).

## Persistence & Sync
- **Local Snapshot**: Results are calculated immediately from the in-memory `GameState`.
- **Firestore**: (Future) Integration with the `PracticeRepository` for historical tracking.

## Security
- Results are immutable once finalized.
- Progression is calculated through the authoritative `ProgressionEngine`.
