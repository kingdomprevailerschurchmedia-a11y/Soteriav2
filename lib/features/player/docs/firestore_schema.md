# Firestore Schema Documentation — Soteria

This document describes the structure of the `users` collection in Cloud Firestore, which serves as the single source of truth for player profiles and progression.

## Collection: `users`
- **Document ID**: Firebase User UID
- **Access Control**: Owner Read/Write only.

### Fields

| Field | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `displayName` | `string` | `"Scholar"` | Player's chosen display name. |
| `email` | `string` | `""` | Synchronized from Firebase Auth. |
| `photoUrl` | `string` | `""` | URL to player's avatar. |
| `level` | `number` | `1` | Current player level. |
| `xp` | `number` | `0` | Cumulative experience points. |
| `coins` | `number` | `0` | In-game currency balance. |
| `currentStreak` | `number` | `0` | Number of consecutive days played. |
| `highestStreak` | `number` | `0` | All-time highest daily streak. |
| `totalQuestionsAnswered` | `number` | `0` | Total questions attempted across all modes. |
| `correctAnswers` | `number` | `0` | Total correct answers. |
| `accuracy` | `number` | `0.0` | Percentage of correct answers (0.0 to 1.0). |
| `gamesPlayed` | `number` | `0` | Total competitive matches played. |
| `gamesWon` | `number` | `0` | Total competitive matches won. |
| `practiceSessions` | `number` | `0` | Count of practice mode attempts. |
| `proSessions` | `number` | `0` | Count of Pro mode attempts. |
| `versusMatches` | `number` | `0` | Count of 1v1 Versus matches. |
| `tournamentMatches` | `number` | `0` | Count of Tournament participations. |
| `favoriteCategories` | `array<string>` | `[]` | List of preferred learning categories. |
| `preferredLanguage` | `string` | `"en"` | UI language preference. |
| `avatarFrame` | `string` | `"default"` | ID of the equipped avatar frame. |
| `badges` | `array<string>` | `[]` | List of earned badge IDs. |
| `achievements` | `array<string>` | `[]` | List of unlocked achievement IDs. |
| `role` | `string` | `"user"` | System role (`user`, `moderator`, `admin`). |
| `accountStatus` | `string` | `"active"` | Status (`active`, `suspended`, `deleted`). |
| `createdAt` | `timestamp` | `now()` | Document creation time. |
| `lastLogin` | `timestamp` | `now()` | Last successful authentication time. |
| `updatedAt` | `timestamp` | `now()` | Last document modification time. |
| `settings` | `map` | `{}` | Key-value store for player preferences. |
| `version` | `number` | `1` | Schema version for migration logic. |

### Expansion Strategy
- **Seasons**: Add `currentSeasonStats` map.
- **Clubs**: Add `clubId` string and `clubRole` string.
- **Friends**: Use a sub-collection `friends`.
- **Learning Insights**: Use a sub-collection `insights` or a separate top-level collection linked by UID.
