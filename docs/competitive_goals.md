# Competitive Goals, Challenges & Objectives

Soteria provides players with dynamic and persistent competitive objectives to encourage participation and provide a sense of direction within the competitive ecosystem.

## Architecture

The Goal System is an **Observation & Evaluation Layer** that aggregates data from authoritative systems (Ranking, Statistics, Seasons, Gameplay) to track progress without duplicating primary data.

### Data Flow

```mermaid
graph TD
    STAT[Statistics System] --> EVAL[GoalEvaluationService]
    RANK[Ranking System] --> EVAL
    QUIZ[Quiz Results] --> EVAL
    
    EVAL --> |CompetitiveGoal| REPO[GoalRepository]
    REPO --> |Firestore| DB[(users/{userId}/competitive_goals)]
    
    REPO --> |State| PROV[goalProviders]
    PROV --> UI[CompetitiveGoalsScreen]
```

## Goal Types

- **DAILY**: Short-term objectives refreshed every 24 hours (e.g., "Play 3 competitive games").
- **WEEKLY**: Medium-term challenges (e.g., "Win 10 games this week").
- **SEASONAL**: Objectives tied to the lifecycle of a specific season (e.g., "Reach Diamond Tier").
- **CAREER**: Long-term milestones (e.g., "Reach 1,000 career wins").

## Evaluation Rules

- **Game Count**: Tracks participation in competitive modes (Tournament, Versus, Pro).
- **Wins**: Tracks successes based on performance ratings (S/A tier results).
- **Rank**: Evaluates if the player has reached or exceeded a target Rank Tier.
- **Personal Best**: Compares current performance against historical records in statistics.
- **Streak**: Evaluates current or highest winning streaks.

## Implementation Details

- **Authoritative Progress**: Progress is recalculated from raw game results and stats to ensure integrity. Evaluation occurs whenever authoritative providers emit new state.
- **Idempotency**: Goal completion and reward distribution are idempotent to prevent duplicate grants.
- **Expiration**: Goals use server-authoritative time to manage transition between Daily/Weekly periods.
- **Deep Links**: Tapping a goal card routes the player back to the relevant feature (e.g., "Continue Mission" routes to the shell).

## UI Components

- **Missions & Goals Screen**: A dedicated dashboard categorized by period (Today, This Week, Season, Career).
- **Goal Card**: Premium card with progress bars, type badges, and expiry timers.
- **Profile Integration**: A summary card on the Competitive Profile showing high-level mission progress.

## Security

- **User Isolation**: Goal progress and status are strictly private to the owner.
- **Server Authority**: While the client observes and evaluated for immediate feedback, authoritative completion and reward eligibility are determined by server-side logic in the production environment.
