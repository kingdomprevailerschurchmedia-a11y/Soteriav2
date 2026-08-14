# Implementation Plan - Competitive Season Notifications, Events & Live Operations

This plan outlines the implementation of a reliable competitive event communication system, including a Live Event architecture and a Live Operations foundation.

## User Review Required

> [!IMPORTANT]
> The existing `NotificationRepository` uses local `SharedPreferences`. To meet the "Server-Authoritative" requirement, I will introduce a `FirestoreNotificationRepository` for competitive notifications, while keeping local storage for less critical ones or as a cache.

> [!IMPORTANT]
> A new `LiveEvent` model and architecture will be introduced, separate from the existing `Tournament` system, to support broader live operations like XP boosts and special challenges.

## Proposed Changes

### Domain Layer

#### [MODIFY] [CompetitiveEventType](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/competitive_event.dart)
- Add `liveEventStarted`, `liveEventEnding`, `systemAnnouncement`, `rematchRequest`.

#### [MODIFY] [NotificationType](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/notifications/domain/models/app_notification.dart)
- Add missing types: `seasonStarted`, `liveEventStarted`, `liveEventEnding`, `rematchRequest`.

#### [NEW] [LiveEvent](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/live_event.dart)
- Definition for scheduled live events (name, status, timing, rules, rewards, eligibility).

#### [NEW] [LiveEventRepository](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/repositories/live_event_repository.dart)
- Contract for fetching and observing live events.

#### [NEW] [LiveOperationsRepository](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/repositories/live_operations_repository.dart)
- Contract for server-controlled feature flags and UI messaging (Remote Config integration).

---

### Data Layer

#### [NEW] [FirestoreNotificationRepository](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/notifications/data/repositories/firestore_notification_repository.dart)
- Implements `NotificationRepository` using Firestore for persistence.
- Supports pagination and unread counts.

#### [NEW] [FirestoreLiveEventRepository](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/data/repositories/firebase_live_event_repository.dart)
- Implements `LiveEventRepository` using Firestore.

#### [NEW] [FirebaseLiveOperationsRepository](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/data/repositories/firebase_live_operations_repository.dart)
- Implements `LiveOperationsRepository` using Firebase Remote Config.

---

### Presentation Layer (Riverpod)

#### [MODIFY] [notification_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/notifications/providers/notification_providers.dart)
- Add `unreadNotificationCountProvider`.
- Update `notificationListProvider` to support pagination.

#### [NEW] [live_event_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/providers/live_event_providers.dart)
- `liveEventsProvider`, `activeLiveEventsProvider`, `eventDetailsProvider`.

---

### UI Layer

#### [MODIFY] [NotificationCenterScreen](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/notifications/screens/notification_center_screen.dart)
- Implement grouped list (Today, Earlier, Season).
- Use `CompetitiveNotificationCard`.

#### [NEW] [CompetitiveNotificationCard](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/notifications/widgets/competitive_notification_card.dart)
- Premium notification card matching design system.

#### [NEW] [LiveEventsScreen](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/live_events_screen.dart)
- Discovery screen for active and upcoming events.

#### [NEW] [LiveEventDetailsScreen](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/live_event_details_screen.dart)
- Detailed view with rules, rewards, and participation CTA.

#### [NEW] [LiveEventCard](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/live_event_card.dart)
- Card for event discovery.

#### [NEW] [EventCountdownWidget](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/event_countdown_widget.dart)
- Reusable countdown using server time.

---

### Services & Integration

#### [MODIFY] [CompetitiveEventObserver](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/notifications/services/competitive_event_observer.dart)
- Add handling for New Season Started and Live Events.

#### [MODIFY] [NotificationCoordinator](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/notifications/services/notification_coordinator.dart)
- Ensure it handles new competitive types and deep linking.

#### [MODIFY] [AppSettings](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/settings/domain/models/app_settings.dart)
- Add notification preferences for competitive categories.

## Verification Plan

### Automated Tests
- `flutter test test/features/notifications/firestore_notification_repository_test.dart`
- `flutter test test/features/player/live_event_logic_test.dart`
- `flutter test test/features/notifications/notification_grouping_test.dart`

### Manual Verification
- Verify notification grouping in Notification Center.
- Verify Live Event countdowns and status transitions.
- Verify deep links from notifications to Season/Event details.
- Verify unread count badge on Profile/Notification icon.
