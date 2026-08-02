# Security Ownership Matrix — Soteria

This document classifies every field in the `users` collection by its write authority and read visibility.

## Collection: `users`

| Field | Read | Write | Justification |
| :--- | :--- | :--- | :--- |
| `uid` | Owner / Admin | None (Doc ID) | System identifier. |
| `displayName` | Public | **Client** | User identity, allowed for personalization. |
| `email` | Owner / Admin | None | Linked to Auth identity. |
| `photoUrl` | Public | **Client** | User identity, allowed for personalization. |
| `level` | Public | **Server Only** | Sensitive progression; anti-cheat protection. |
| `xp` | Public | **Server Only** | Sensitive progression; anti-cheat protection. |
| `coins` | Owner | **Server Only** | Economic value; anti-tampering required. |
| `currentStreak` | Public | **Server Only** | Verified by server daily logic. |
| `highestStreak` | Public | **Server Only** | Verified by server daily logic. |
| `totalQuestions` | Public | **Server Only** | Performance metric. |
| `correctAnswers` | Public | **Server Only** | Performance metric. |
| `accuracy` | Public | **Server Only** | Derived metric; server calculated. |
| `gamesPlayed` | Public | **Server Only** | Match history integrity. |
| `gamesWon` | Public | **Server Only** | Match history integrity. |
| `badges` | Public | **Server Only** | Reward system integrity. |
| `achievements` | Public | **Server Only** | Reward system integrity. |
| `role` | Owner / Admin | **Admin Only** | Privilege escalation protection. |
| `accountStatus` | Owner / Admin | **Admin Only** | Safety and moderation control. |
| `createdAt` | Owner / Admin | None | Audit trail integrity. |
| `lastLogin` | Owner / Admin | **Client (Bootstrap)** | Updated during session initialization. |
| `settings` | Owner | **Client** | Safe user preferences (theme, language). |
| `version` | Owner / Admin | **Server Only** | Database migration control. |

## Authority Key

- **Client**: The Flutter app can directly write/update this field.
- **Server Only**: Only authoritative Cloud Functions or Admin SDKs can update this field.
- **Admin Only**: Restricted to personnel with the `admin` role.
- **None**: Set once and immutable.
