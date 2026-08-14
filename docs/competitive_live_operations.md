# Competitive Live Operations & Notifications

This document outlines the architecture for competitive event communication and live operations in Soteria.

## Notification Architecture

Soteria uses a **Server-Authoritative** notification system powered by Firestore.

### Key Components
- **FirestoreNotificationRepository**: Persists notifications in `users/{userId}/notifications`.
- **CompetitiveEventObserver**: Monitors Riverpod providers and emits `CompetitiveEvent`s which are then mapped to `AppNotification`s and `CompetitiveActivityEvent`s.
- **NotificationCoordinator**: Handles FCM registration, foreground message processing, and deep-linking.

### Notification Types
- `seasonStarted`, `seasonEnding`, `seasonResults`
- `rankPromoted`, `rankDemoted`
- `rewardReceived`
- `milestoneReached`, `achievementUnlocked`
- `matchCompleted`, `rematchRequest`
- `liveEventStarted`, `liveEventEnding`

### Grouping logic
The Notification Center groups items into:
1. **Today**: Events from the current calendar day.
2. **Season**: High-priority seasonal announcements.
3. **Earlier**: Historical notifications.

## Live Event Architecture

Live Events allow for scheduled competitive content like "Weekend Rush" or "Double XP".

### Data Model
`LiveEvent` includes:
- `eventId`, `name`, `description`
- `status` (`upcoming`, `active`, `ending`, `completed`)
- `startAt`, `endAt` (Server-authoritative timing)
- `rewardConfig` (e.g., `xp_multiplier`, `coins`)
- `rules` & `eligibility`

### Screens
- **LiveEventsScreen**: Discovery feed for active and upcoming events.
- **LiveEventDetailsScreen**: Comprehensive view of rules, rewards, and countdowns.

## Live Operations Foundation

Integration with **Firebase Remote Config** allows for:
- Feature flags for competitive modes.
- Tuning event visibility.
- Dynamic UI messaging without app updates.

## Deep Links
Notifications support intelligent routing:
- `season` -> Current Season Screen
- `events` -> Live Events Discovery or Details
- `profile` -> Player Profile / Rank
- `rewards` -> Wallet / Rewards History
- `versus` -> Versus Lobby

## Security & Idempotency
- Notifications are owned by the authenticated user.
- `deduplicationKey` prevents spamming the same event (e.g., multiple "Season Ending" alerts).
- Firestore rules ensure users only access their own notification subcollection.
