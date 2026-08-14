# Implementation Plan - Competitive Social Activity, Rivalry Feed & Player Presence

Implement a lightweight competitive social layer that keeps players informed about their network's competitive status and activities.

## User Review Required

> [!IMPORTANT]
> Presence states will be coarse (Online, Recently Active, Offline) to respect privacy.
> Activity feed will be aggregated from friends and rivals based on existing social connections.

## Proposed Changes

### Domain Layer - Models

#### [NEW] [player_presence.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/player_presence.dart)
- `PlayerPresence` model with status (online, away, offline, inMatch) and privacy controls.

#### [MODIFY] [competitive_activity_event.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/competitive_activity_event.dart)
- Add optional actor profile data to the model if it helps avoid extra lookups, or rely on existing profile providers.

### Data Layer - Repositories

#### [NEW] [presence_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/repositories/presence_repository.dart)
- Interface for updating and observing player presence.

#### [NEW] [firebase_presence_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/data/repositories/firebase_presence_repository.dart)
- Firestore Realtime Database or Firestore implementation for presence tracking.

#### [MODIFY] [activity_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/repositories/activity_repository.dart)
- Add `getSocialActivityFeed(String userId, List<String> socialIds)` to aggregate friend/rival activity.

### Presentation Layer - Providers & UI

#### [NEW] [presence_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/providers/presence_providers.dart)
- Providers to observe presence of friends and rivals.

#### [MODIFY] [activity_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/providers/activity_providers.dart)
- Aggregate feed provider that combines user, friend, and rival activity.

#### [MODIFY] [competitive_activity_card.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/activity/competitive_activity_card.dart)
- Update to show actor name and avatar for social activities.

#### [MODIFY] [competitive_activity_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/competitive_activity_screen.dart)
- Add filters: ALL, FRIENDS, RIVALS, YOU.
- Integrate presence indicators.

#### [NEW] [player_presence_indicator.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/presence/player_presence_indicator.dart)
- Visual indicator for online/offline/in-match status.

### Integration

#### [MODIFY] [rivalry_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/social/presentation/screens/rivalry_screen.dart)
- Display filtered activity feed for the specific rivalry.

## Verification Plan

### Automated Tests
- Unit tests for `PlayerPresence` and `CompetitiveActivity` logic.
- Repository tests for social feed aggregation.
- Security tests ensuring private activities are not exposed.

### Manual Verification
- Verify activity feed updates when a friend/rival completes a match (mocked).
- Verify presence transitions (Online -> Offline -> In Match).
- Verify privacy settings (Presence visibility).
- Test responsiveness on multiple device sizes.
