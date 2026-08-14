# Implementation Plan - Competitive Social Layer (Story 9.29)

This plan implements the competitive social layer for Soteria, allowing players to discover, connect with, follow, and compete against each other. It reuses existing player identity and profile systems.

## User Review Required

> [!IMPORTANT]
> - This implementation uses top-level collections `friendships`, `friend_requests`, and `follows` for efficient querying and scalability, while maintaining bi-directional friendship logic.
> - Following is implemented as a one-way connection, distinct from two-way friendships.
> - Privacy settings will be respected, but the initial implementation will focus on the core connection logic.

## Proposed Changes

### [Component] Social Domain Models

Create models for relationships, requests, and activity.

#### [NEW] [relationship_status.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/domain/models/relationship_status.dart)
Defines the state of connection between two players: `none`, `requestSent`, `requestReceived`, `friends`, `blocked`.

#### [NEW] [friendship.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/domain/models/friendship.dart)
Model representing a confirmed friendship.

#### [NEW] [friend_request.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/domain/models/friend_request.dart)
Model representing a pending friend request.

#### [NEW] [follow.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/domain/models/follow.dart)
Model representing a one-way follow relationship.

---

### [Component] Social Data & Repositories

Implement Firestore repositories for social operations.

#### [NEW] [social_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/domain/repositories/social_repository.dart)
Interface for managing friendships, follows, and blocks.

#### [NEW] [firebase_social_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/data/repositories/firebase_social_repository.dart)
Firestore implementation of `SocialRepository`.

---

### [Component] Social Providers

State management using Riverpod.

#### [NEW] [social_providers.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/presentation/providers/social_providers.dart)
Provides streams of friends, requests, and relationship status for a given user.

---

### [Component] UI Enhancements

Update existing screens and create new ones.

#### [MODIFY] [public_competitive_profile_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/screens/public_competitive_profile_screen.dart)
Add "Add Friend", "Follow", "Accept/Decline Request", and "Remove Friend" buttons based on relationship status.

#### [NEW] [friends_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/presentation/screens/friends_screen.dart)
Display friends list and incoming requests.

#### [NEW] [friend_requests_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/presentation/screens/friend_requests_screen.dart)
Detail view for managing incoming and outgoing requests.

#### [MODIFY] [player_search_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/screens/player_search_screen.dart)
Update search results to show relationship status or quick actions.

---

### [Component] Preview & Fixtures

#### [NEW] [social_fixtures.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/preview/social_fixtures.dart)
Deterministic fixtures for various social states.

#### [NEW] [social_previews.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/preview/social_previews.dart)
Register social screens and components in the preview gallery.

## Verification Plan

### Automated Tests
- **Domain Tests**: Test friendship state transitions (None -> Requested -> Friends -> None).
- **Security Tests**: Verify that users cannot accept requests they didn't receive.
- **UI Tests**: Verify that the correct buttons appear on the public profile for each relationship state.

### Manual Verification
- Deploy to device/emulator.
- Search for a player.
- Send friend request.
- Switch users (mock) and accept request.
- Verify friends list update.
- Verify challenge integration from friends list.
