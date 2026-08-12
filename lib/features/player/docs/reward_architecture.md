# Competitive Reward Architecture

## Overview
The Reward System determines and distributes prizes to players based on their performance in a completed competitive season. It is designed to be server-authoritative, idempotent, and secure.

## Key Components

### 1. Domain Models
- **SeasonRewardDefinition**: Describes what rewards are available for a specific season (e.g., Top 10, Gold Tier).
- **RewardGrant**: Records a specific reward awarded to a user. Tracks status (Eligible, Pending, Granted, Claimed).

### 2. Reward Eligibility Service
- Consumes authoritative `SeasonResult` (from Story 9.5).
- Evaluates eligibility based on:
  - **Position**: Global leaderboard rank.
  - **Rank**: Competitive tier (e.g., Diamond+).
  - **Participation**: Basic engagement criteria.

### 3. Reward Repository
- **FirebaseRewardRepository**: Handles all Firestore operations.
- Uses `season_reward_definitions` and `season_reward_grants` collections.
- Implements `claimReward` with transaction safety.

### 4. Integration
- **XP**: Reuses `XpTransaction` and `FirebasePlayerProgressionRepository`.
- **Economy**: Updates `coins` and `tokens` in the `users` collection (authoritative via Firestore triggers or server-side logic).

## Security & Idempotency
- **Idempotency**: Reward grants use deterministic IDs (e.g., `seasonId_userId_rewardId`) to prevent duplicate awards.
- **Server Authority**: Clients can only request a `claim`. The server determines eligibility and grant status.
- **Auditability**: Every reward grant is linked to a `seasonId`, `userId`, and `rewardId`.

## UI Components
- **SeasonRewardSummary**: Premium summary shown at the end of a season.
- **RewardCard**: Detailed view of an individual reward with claim action.
- **RewardHistoryScreen**: Archive of all earned competitive rewards.

## Flow
1. **Season Completion**: Triggered by backend when a season ends.
2. **Result Finalization**: `SeasonResult` is generated (Story 9.5).
3. **Grant Creation**: Server generates `RewardGrant` records based on `SeasonRewardDefinition` and `SeasonResult`.
4. **Client Notification**: Player sees rewards in their history or summary.
5. **Claiming**: If required, player clicks "Claim". Server verifies and updates balance.
