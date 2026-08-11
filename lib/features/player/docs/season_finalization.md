# Season Result Finalization Process

This document outlines the server-authoritative process for finalizing competitive season results and generating immutable historical snapshots.

## Lifecycle Transition

The finalization process is triggered when a season transitions from `ENDING` to `COMPLETED`.

1. **State Trigger**: A scheduled Cloud Function or backend service detects that the current time has passed the `endAt` timestamp of an `ACTIVE` or `ENDING` season.
2. **Locking**: The season status is updated to `COMPLETED`. The Ranking Engine stops accepting new `CompetitiveResult` entries for this `seasonId`.

## Finalization Flow (Server-Authoritative)

The finalization must be **idempotent** and handled in batches to ensure scalability.

### 1. Identify Eligible Players
The system identifies all players who participated in the season. Participation is defined as having at least one `RankTransaction` or `CompetitiveResult` associated with the `seasonId`.

### 2. Capture Final Rank State
For each eligible player, the system reads the authoritative `PlayerProgression` document.
- `finalRankPoints` = `progression.rankPoints`
- `finalTier` = `progression.currentRankTier`
- `finalDivision` = `progression.rankProgress` (or the specific division number if stored)

### 3. Determine Final Leaderboard Position
The system queries the authoritative `season_leaderboard` for the `seasonId`.
- The absolute position of the player on the finalized leaderboard is captured as `finalPosition`.
- If the player is unranked, `finalPosition` is recorded as `0` or `null`.

### 4. Create Immutable Season Result
A new document is created in `users/{userId}/season_results/{seasonId}`.

**Idempotency Strategy**: 
The `documentId` MUST be the `seasonId`. This ensures that even if the finalization process runs multiple times for the same player, only one historical record is created.

**Fields**:
- `seasonId`: (String) from season
- `userId`: (String) from progression
- `seasonName`: (String) from season
- `seasonNumber`: (Number) from season
- `finalPosition`: (Number) from leaderboard
- `finalRankPoints`: (Number) from progression
- `finalTier`: (String) from progression
- `finalDivision`: (Number) from progression
- `previousTier`: (String) captured at season start or first match
- `rankChange`: (Number) `finalRankPoints - initialRankPoints`
- `completedAt`: (Timestamp) authoritative season end time
- `createdAt`: (Timestamp) snapshot generation time
- `statistics`: (Map) Aggregated stats (Matches, Wins, etc.)

### 5. Mark as Finalized
The record is written with `status: "finalized"`. Once written, Security Rules prevent any further modification by the client.

## Security and Immutability

### Firestore Security Rules
```javascript
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId}/season_results/{seasonId} {
      // Players can read their own history
      allow read: if request.auth != null && request.auth.uid == userId;
      
      // Clients can NEVER create or modify historical results
      allow write: if false; 
      
      // System/Admin can write results (handled via Admin SDK)
    }
  }
}
```

## Failure Recovery and Retries

- **Partial Failure**: If a batch of players fails to process, the system can simply re-run the finalization. Because of the deterministic `documentId` (seasonId), existing records will be overwritten with the same data (idempotent) and missing ones will be created.
- **Data Correction**: In case of a system-wide error, an administrative "Correction" process can update records by using an elevated privilege bypass of the security rules.
