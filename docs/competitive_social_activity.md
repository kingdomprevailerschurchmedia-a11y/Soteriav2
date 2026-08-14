# Competitive Social Activity & Player Presence

## Overview
This system provides a lightweight social layer focused on competition. It allows players to stay informed about their network's achievements, match results, and real-time status without the clutter of a traditional social network.

## Core Components

### CompetitiveActivityEvent
Authoritative records of meaningful competitive milestones.
- **Actor-based**: Every activity is tied to a user.
- **Privacy-aware**: Visibility is enforced at the repository and rule layers (Public, Friends, Rivals, Private).
- **Types**: Match results, Rank changes, Achievement unlocks, Mission/Challenge completions.

### PlayerPresence
Real-time status tracking with privacy controls.
- **States**: Online, Recently Active, Offline, In Match.
- **Coarse Detail**: Timestamps and precise locations are not exposed to protect player privacy.
- **Privacy Toggle**: Players can choose to hide their online status or activity.

## Social Feed Architecture
- **Aggregation**: The feed combines a player's own activity with that of their friends and rivals.
- **Cursor Pagination**: Efficient loading of large feeds using timestamp-based cursors.
- **Deduplication**: Idempotent event IDs prevent duplicate entries in the UI.

## UI Integration
- **`CompetitiveActivityScreen`**: Main hub with social filters (ALL, FRIENDS, RIVALS, YOU).
- **`CompetitiveActivityCard`**: Compact, premium cards with actor avatars and presence indicators.
- **`PlayerPresenceIndicator`**: Subtle visual cues on avatars throughout the app.
- **`RivalryScreen` integration**: specialized feed showing only pvp-relevant activity between rivals.

## Security & Anti-Abuse
- **Authoritative Only**: Clients cannot publish arbitrary activities.
- **Data Isolation**: Firestore rules and repository filters ensure users only see activities they are permitted to access.
- **Spam Prevention**: Reuses match verification and event throttling logic.
