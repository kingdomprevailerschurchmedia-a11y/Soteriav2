# Player Presence & Live Status Architecture

## Overview
The Presence system provides real-time awareness of player availability for competitive interactions (challenges, matchmaking). It balances real-time feedback with battery efficiency and player privacy.

## Presence States

| State | Semantic | Visual | Meaning |
| :--- | :--- | :--- | :--- |
| **ONLINE** | Available | Green Dot | App is in foreground and active. |
| **IN_MATCH** | Competing | Swords Icon | Player is currently in a competitive session. |
| **RECENTLY_ACTIVE**| Away | Hollow Circle | App is in background or inactive < 10 mins. |
| **OFFLINE** | Unavailable | Muted Dot | No active session detected. |
| **HIDDEN** | Privacy | Muted Dot | Player chose to hide their status. |

## Heartbeat Mechanism
- **Interval**: 2 minutes.
- **Server Authority**: Uses Firestore `serverTimestamp()` for all updates.
- **Auto-Expiration**: Backend logic (or query filtering) treats presence older than 5 minutes as `OFFLINE`.

## Privacy & Security
- **Coarse Detail**: Precise timestamps are not exposed.
- **User Isolation**: Firestore rules ensure only friends and rivals can read detailed presence.
- **Blocked Users**: Automatically filtered from receiving presence updates.

## Integration
- **Matchmaking**: Displayed online counts help gauge queue times.
- **Social**: Friend lists and Rivalry cards show real-time status.
- **Challenges**: CTA logic changes based on whether the opponent is `IN_MATCH` or `OFFLINE`.

## Performance
- **Aggregated Reads**: Multiple presence states are fetched in a single batched listener.
- **Lifecycle Awareness**: Heartbeat pauses when the app is backgrounded to save battery.
