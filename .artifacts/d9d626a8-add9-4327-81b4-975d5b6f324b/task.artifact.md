# Task List - Story 9.28

## Phase 1: Domain & Data Layer
- [ ] Update `CompetitiveEventType` and `NotificationType` enums [/]
- [ ] Implement `LiveEvent` model [/]
- [ ] Implement `LiveEventRepository` and `LiveOperationsRepository` interfaces [/]
- [ ] Implement `FirestoreNotificationRepository` [/]
- [ ] Implement `FirestoreLiveEventRepository` [/]
- [ ] Implement `FirebaseLiveOperationsRepository` [/]

## Phase 2: Presentation & State Management
- [ ] Add `live_event_providers.dart` [/]
- [ ] Update `notification_providers.dart` for unread count and pagination [/]
- [ ] Update `CompetitiveEventObserver` with new types [/]

## Phase 3: UI & Components
- [ ] Create `CompetitiveNotificationCard` [/]
- [ ] Create `LiveEventCard` and `EventCountdownWidget` [/]
- [ ] Update `NotificationCenterScreen` with grouping [/]
- [ ] Implement `LiveEventsScreen` [/]
- [ ] Implement `LiveEventDetailsScreen` [/]

## Phase 4: Integration & UX
- [ ] Implement deep link handling in `NotificationCoordinator` [/]
- [ ] Add notification preferences to settings [/]
- [ ] Add unread badge to navigation [/]

## Phase 5: Verification
- [ ] Create Preview fixtures and register in Gallery [/]
- [ ] Implement domain and repository tests [/]
- [ ] Prepare Golden Tests [/]
- [ ] Update documentation [/]
