# Competitive Goals & Progression Roadmap

This document outlines the goal system and progression roadmap in Soteria, designed to motivate players through clear, attainable objectives.

## Goal Architecture

Soteria uses a tiered goal system that automatically tracks progress from server-authoritative competitive data.

### Goal Types
- **Daily**: Short-term objectives (e.g., play 3 games).
- **Weekly**: Medium-term challenges (e.g., win 10 matches).
- **Seasonal**: Tied to the current competitive season (e.g., reach Gold I).
- **Career**: Long-term milestones (e.g., achieve 90% all-time accuracy).

### Goal Categories
- `win`: Number of competitive wins.
- `gameCount`: Total games played.
- `rank`: Specific rank tier targets.
- `score`: Single match or total score targets.
- `streak`: Win streak milestones.
- `personalBest`: Breaking records (e.g., peak global position).

## Progression Roadmap

The Progression Roadmap provides a visual path of all competitive ranks in Soteria.

- **Current State**: Highlights the player's current rank and RP.
- **Future Targets**: Shows upcoming tiers and the requirements to reach them.
- **History**: Marks completed tiers.

## Goal Evaluation

Goal progress is calculated deterministically by the `CompetitiveGoalEvaluationService` using:
1. `QuizResult` history.
2. `CompetitiveStatistics` (streaks, records).
3. `PlayerProgression` (current rank, points).

Evaluation is triggered automatically after matches or when viewing the goals screen.

## Security & Integrity

- **Authoritative Data**: Goals are evaluated against server-verified match results.
- **Immutable Progress**: The client cannot directly increment progress or mark goals as complete.
- **Reward Claims**: Rewards are granted once per goal completion through an idempotent claim process.

## Privacy

- Goals are **private by default**.
- Users can choose to share certain "Public Goals" (e.g., "Chasing Platinum") if supported by their privacy settings.
- Private performance targets (e.g., "Improve Science Accuracy") are never exposed to others.

## UI Integration

- **Competitive Goals Screen**: The main hub for all missions and historical goals.
- **Next Goal Section**: A compact hero card in the Competitive Profile showing the highest priority objective.
- **Goal Details**: Deep dive into target values, deadlines, and rewards.
