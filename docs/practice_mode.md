# Practice Mode

Practice Mode is a non-competitive, learning-focused game mode in Soteria. It allows users to train on specific categories or their personalized interests without the pressure of competitive rankings.

## Key Features
- **Personalized Content**: Defaults to user interests selected during onboarding.
- **Configurable Sessions**: Users can manually select categories, difficulty, and question count.
- **Immediate Feedback**: Correct/Incorrect status and educational explanations are shown immediately after answering.
- **Question Review**: Users can review all questions and their answers at the end of the session.
- **Non-Competitive**: No countdown timers (optional), infinite lives, and no leaderboard impact.

## Architecture
Practice Mode consumes the canonical Question Platform:
1. **Setup**: `PracticeLobbyScreen` allows configuring the session.
2. **Selection**: Uses `QuestionSelectionService` to build a balanced question pool.
3. **Gameplay**: Reuses the central `GameEngine` with a `GameMode.practice` configuration.
4. **Results**: `PracticeResultsScreen` displays performance metrics and a review list.

## Feedback & Explanations
Practice Mode is unique in that it displays `QuestionExplanationView` immediately after an answer is submitted. The `GameEngine` waits for a manual "Continue" action in this mode before moving to the next question.

## Scoring & Rewards
While Practice Mode doesn't impact competitive rank, it contributes to overall player level (XP) and can provide small coin rewards based on performance.
