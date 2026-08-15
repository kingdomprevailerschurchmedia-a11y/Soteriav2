# Practice History & Personal Performance

This document describes the architecture and implementation of Practice History in Soteria.

## Overview

Practice History is a personal learning record that tracks a user's performance across all Practice sessions. It is designed to help users understand their progress, identify strengths and weaknesses, and stay motivated without the pressure of competitive rankings.

## Data Model

### PracticeResult
Persistent record of a single practice session.
- `sessionId`: Unique ID (also used for idempotency).
- `userId`: Owner of the result.
- `completedAt`: Timestamp of completion.
- `totalQuestions`, `correctAnswers`, `accuracy`, `score`, `totalTime`.
- `categoryPerformance`: Breakdown per category.
- `difficultyPerformance`: Breakdown per difficulty.
- `reviewItems`: Detailed question-by-question review data.

### PracticeHistory
Aggregated summary of multiple results.
- `totalSessions`, `totalQuestions`, `averageAccuracy`.
- `categoryPerformance`: Accumulated accuracy and question counts per category.
- `trends`: Chronological list of accuracy data points.
- `personalBests`: Milestones like highest score or longest session.

## Persistence

Results are stored in Firestore at:
`users/{userId}/practice_results/{resultId}`

### Security & Privacy
- Users can only read/write their own `practice_results` collection.
- Practice history is private and not exposed to other users or leaderboards.

## Performance Tracking

### Accuracy Trends
Trends are derived from recent sessions. 
- **Improving**: Recent average accuracy is significantly higher than previous average.
- **Stable**: Accuracy remains within a +/- 5% range.
- **Declining**: Recent average is lower than previous average.

### Category Performance
Aggregates accuracy across all sessions for each category, allowing users to see where they need more focus.

## Implementation Details

### Provider Layer
- `practiceHistoryListProvider`: Fetches the last 20-50 results from Firestore.
- `practiceHistoryProvider`: Aggregates the list into a `PracticeHistory` summary object.
- `practiceResultRepositoryProvider`: Interface for Firestore operations.

### UI Screens
- **Practice Journey**: Main summary view with trends and category charts.
- **Session List**: Scrollable list of past sessions.
- **Session Details**: Deep dive into a specific session with question review.

## Offline Support
The system leverages Firestore's local persistence. Recent results are cached and can be viewed offline. New results are queued for synchronization when connectivity is restored.

## Idempotency
`sessionId` is used as the document ID in Firestore to ensure that a single session cannot produce duplicate historical records.
