# Competitive Seasons Architecture

Soteria implements a live competitive season experience, where players climb ranks, earn points (RP), and compete on leaderboards during defined time periods.

## Season Lifecycle

A season moves through several states, determined authoritatively by the server:

- **UPCOMING**: The season has been defined but has not yet started. Countdown to start is displayed.
- **ACTIVE**: Gameplay contributes to season rank and milestones.
- **ENDING**: The season is in its final phase (last 24 hours). Visual urgency is applied.
- **FINALIZING**: The season has ended, and final results/rewards are being calculated.
- **COMPLETED**: The season is over, and results are finalized in history.
- **ARCHIVED**: Historical data preserved for reference.

## Components

### CompetitiveSeasonScreen
The main dashboard for the current season. It provides a comprehensive view of:
- **Season Hero**: Status badge and real-time countdown.
- **Your Standing**: Current rank, RP, and progress to the next level.
- **Leaderboard Preview**: Top 3 players and a link to the full leaderboard.
- **Season Milestones**: Progress toward season-specific goals (e.g., "Win 10 matches").
- **Season Rewards**: Preview of rewards based on rank and milestones.

### SeasonHeader
A reusable widget for the main dashboard that provides a quick summary of the current season and deep-links to the Season Dashboard.

## Integration

### Rank Integration
Seasons are the primary context for rank progression. Each season can have its own `rankConfigId` to allow tuning of RP gains and thresholds.

### Leaderboard Integration
Each season maintains a dedicated leaderboard. The `leaderboardControllerProvider` handles pagination and user position highlighting.

### Rewards & Milestones
Rewards are granted upon reaching specific rank tiers or completing season milestones. These are defined authoritatively via `SeasonRewardDefinition`.

## Transition & Idempotency
Season transitions are handled reactively via Riverpod streams. Historical results are preserved in the `season_results` collection, ensuring that a new season initialization does not overwrite previous career data.
