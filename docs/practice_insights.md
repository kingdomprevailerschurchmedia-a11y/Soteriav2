# Practice Mode Polish, Streaks & Learning Insights

This document describes the implementation of the advanced learning feedback and polish layer for Practice Mode.

## Learning Insights Engine

The system uses a deterministic `PracticeInsightEngine` to analyze session results and historical performance.

### Insight Rules
- **Strong Category**: accuracy >= 85% with at least 3 questions.
- **Improvement Opportunity (Weakness)**: accuracy < 60% with at least 3 questions.
- **Improvement Detection**: Compares current accuracy with the previous session. If improvement >= 15%, a "Great Improvement" insight is generated.
- **Mastery Level**: Overall accuracy >= 90%.
- **Challenge Detection**: Identifies difficulty levels with < 50% accuracy.

### Minimum Sample Size
A minimum of **3 questions** per category is required before the system declares a strength or weakness, preventing misleading feedback from small samples.

## Recommendations

The `PracticeRecommendationService` suggests the most impactful next step for the user.

### Recommendation Logic
1. **Weak Area Focus**: If a weakness is detected, recommend practicing that specific category.
2. **Level Up**: If the user achieves >= 90% accuracy, recommend increasing the difficulty level.
3. **solidification**: Fallback to repeating the current configuration to build consistency.

## Progression & Streaks

### Daily Activity Streak
Soteria tracks a global daily activity streak. Completing any Practice session contributes to this streak.
- **Idempotency**: Sessions are only processed once based on their `sessionId`.
- **Streak Calculation**: Incremented if active on consecutive days; reset if a day is missed.

### XP & Leveling
Practice Mode uses the `PracticeProgressionPolicy`:
- 10 XP per correct answer.
- 10 XP session completion bonus.
- 25 XP perfect round bonus.

## UI / UX Polish
- **Subtle Animations**: Uses `SoteriaFadeIn` and `SoteriaSlideUp` for a premium entrance.
- **Visual Hierarchy**: Primary focus on overall accuracy and insights, followed by recommendations and detailed review.
- **Filtering**: Question review can be filtered to show "All" or "Incorrect" only.
- **Responsive Design**: optimized for devices from 320px up to tablets.

## Offline Behavior
Insights and recommendations are calculated locally from the session snapshot, ensuring full functionality even if the device goes offline immediately after completing a session.
