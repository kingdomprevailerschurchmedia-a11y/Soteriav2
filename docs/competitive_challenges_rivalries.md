# Competitive Challenges & Rivalries Architecture

## Overview
This system enables players to compete directly with friends and rivals through structured, measurable objectives. It also tracks long-term performance trends between specific pairs of players.

## Core Components

### CompetitiveChallenge
Represents a structured showdown between two players.
- **Types**: Match Wins, Match Score, Win Streak, Total Points, Accuracy, Category Mastery.
- **Lifecycle**: Pending -> Acceptance -> Active -> Completed/Expired.
- **Progress**: Server-authoritative tracking for both challenger and opponent.

### Rivalry & Head-to-Head
Meaningful repeated competition is tracked as a Rivalry.
- **HeadToHeadSummary**: Aggegrated statistics (Record, Form, Streak, Win Rate).
- **Rivalry States**: Determined by consistency and results (Emerging, Active, Dominant).

## Integration

### Authoritative Triggers
Challenge progress is updated via `CompetitiveResult` events. A single match can contribute to multiple active challenges, missions, and goals.

### Rewards & Progression
Challenges leverage the existing `RewardRepository` for granting XP and Coins. High-level rivalry milestones contribute to player achievements.

## Security & Anti-Abuse
- **Self-Challenge**: Prevented at the controller layer.
- **Data Isolation**: User A cannot access User B's private challenge details.
- **Farming Protection**: Reuses existing match verification and anti-cheat infrastructure.

## UI Hubs
- **Challenge Center**: Centralized management of incoming and outgoing invites.
- **Head-to-Head Screen**: Detailed athletic comparison between two players.
- **Rivalry Screen**: High-level summary of a player's relationship with a specific rival.
- **Challenge History**: Archive of past showdowns and results.
