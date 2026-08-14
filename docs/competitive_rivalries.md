# Competitive Rivalries & Social Competition

Soteria encourages healthy competition between friends through the **Friends Leaderboard** and **Player Rivalries**. These systems leverage authoritative match data to create a motivating social loop.

## Friends Leaderboard

The Friends Leaderboard ranks a user against their connected friends for the current season.

- **Source**: Reuses the authoritative season ranking (RP/Points) from the `leaderboard` system.
- **Filtering**: Currently focused on the active season.
- **Privacy**: Respects player visibility settings.
- **Architecture**: `friendsLeaderboardProvider` aggregates friend IDs from the social system and fetches their leaderboard entries.

## Player Rivalries

A Rivalry represents a persistent competitive relationship between two players who frequently compete against each other.

### Data Model (`PlayerRivalry`)
- `wins`/`losses`/`draws`: Head-to-head record.
- `lastMatchAt`: Timestamp of the most recent encounter.
- `recentForm`: A sequence of recent outcomes (W/L) in head-to-head matches.

### Calculation Logic
Rivalries are derived on-the-fly from the `match_results` collection. This ensures that the statistics are always authoritative and cannot be manipulated by the client.

## Head-to-Head Deep Dive

Players can view a detailed breakdown of their history with any specific rival.
- **Match History**: Filtering the global match history to show only matches between the two players.
- **Competitive Comparison**: Comparing rank, RP, and accuracy.

## Social Activity

Competitive milestones from friends are surfaced in the activity feed:
- **Rank Ups**: When a friend reaches a new competitive tier.
- **Overtakes**: When the user passes a friend on the leaderboard.
- **Rivalry Milestones**: Reaching 5, 10, or 25 matches with a specific rival.

## Security & Anti-Abuse

- **Server Authority**: All match results and ranking changes are processed on the server.
- **Rate Limiting**: (Planned) Prevent artificial match inflation through excessive challenging.
- **User Isolation**: Users cannot view private match details of their friends beyond the high-level result and score.

## Preview System

Use the `SocialPreviews` in the Developer Gallery to visualize:
- Friends leaderboard rankings.
- Rivalry cards with "You Lead" / "Rival Leads" status.
- Head-to-Head statistics and form indicators.
- Social activity feed events.
