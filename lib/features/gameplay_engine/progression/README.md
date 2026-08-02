# Progression Engine

Soteria's central engine for managing player growth, engagement, and rewards.

## Architecture

- **ScoreEngine**: Handles points calculation based on correctness, streaks, and speed.
- **XPManager**: Manages experience points and round-end bonuses.
- **LevelEngine**: Calculates level growth using non-linear (exponential) curves.
- **StreakEngine**: Tracks current, session, and all-time streaks.
- **ProgressionEngine**: The orchestrator that executes the pipeline and emits events.

## Pipeline

1. **AnswerResult** -> Input
2. **Score Calculation** -> Base + Streak + Speed
3. **XP Calculation** -> Base * Mode Multiplier
4. **Streak Update** -> Increment or Reset
5. **Level Check** -> XP Threshold Check
6. **Reward Hooks** -> Level Up / Milestone detection
7. **Analytics/State** -> Emits events and updates Riverpod state.

## State Management

Use `progressionProvider` to access the current `ProgressSnapshot`.
Granular providers like `scoreProvider`, `xpProvider`, and `levelProvider` are available for UI performance.

## Policies

Game modes define their own `ProgressionPolicy`. This allows Practice mode to have lower XP/Score rewards compared to Pro mode without changing engine code.
