# Competitive Missions Architecture

## Overview
Competitive Missions are short-term objectives (Daily, Weekly, Seasonal) that encourage healthy engagement and learning. They form a core part of the player progression loop in Soteria.

## Principles
- **Healthy Engagement**: No casino-style pressure, no manipulative streaks, no forced daily usage.
- **Server Authority**: All mission generation, progress, and completion are determined server-side.
- **Fairness**: Missions are tailored to user eligibility and rank.
- **Learning-Oriented**: Objectives focus on improving performance and accuracy.

## Data Model

### MissionDefinition
Centrally managed configuration for a mission.
- `type`: The kind of objective (Play, Win, XP, etc.)
- `period`: Daily, Weekly, Seasonal, or Career.
- `target`: The value required for completion.
- `reward`: XP or other items granted on completion.

### UserMissionState
User-specific tracking for a mission instance.
- `progress`: Current authoritative progress.
- `status`: Active, Completed, Claimed, or Expired.
- `startAt` / `endAt`: The validity period for the mission.

## Integration

### Authoritative Triggers
Mission progress is updated by the server in response to verified events:
- `matchCompleted`
- `matchWon`
- `xpEarned`
- `achievementUnlocked`

### Rewards
Rewards are granted server-side. The client presents a "Claim" action which is idempotent and exactly-once.

### Notifications
- `missionCompleted`: Notifies the user when an objective is finished.
- `missionExpiring`: Alerts the user when a high-value mission is about to end.

## UI Components
- `CompetitiveMissionsScreen`: The main hub for all active objectives.
- `CompetitiveMissionCard`: Premium card displaying title, progress, and rewards.
- `MissionDetailsScreen`: Deep dive into specific requirements and rewards.
- `MissionHistoryScreen`: Archive of past achievements.

## Caching & Offline
- Mission state is cached locally for immediate presentation.
- Offline completion or claiming is strictly prohibited.
- Refreshing the mission hub triggers a sync with server-authoritative time and state.
