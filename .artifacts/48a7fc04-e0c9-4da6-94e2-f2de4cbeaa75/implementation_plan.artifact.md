# Implementation Plan - Story 11.11 Social Activity

Implement a secure, scalable Social Activity system for Soteria that allows players to see meaningful updates from their social graph and competitive ecosystem.

## User Review Required

> [!IMPORTANT]
> **Authoritative Verification on Spark**: Since Soteria is on the Firebase Spark (free) plan, we cannot use Cloud Functions for backend verification. We will use Firestore Security Rules with `existsAfter` to verify that activity records correspond to legitimate authoritative documents (e.g., an achievement unlock or a rank transaction).

> [!NOTE]
> **Scalability Limitation**: Firestore `whereIn` queries are limited to 30 items. This means the social feed can aggregate activity from up to 30 friends/rivals at a time in a single query. This is a known Spark/Firestore limitation.

## Proposed Changes

### 1. Domain Models [MODIFY]
#### [CompetitiveActivityEvent](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/competitive_activity_event.dart)
- Add `ActivityVisibility` enum: `public`, `friends`, `private`.
- Add `visibility` field to `CompetitiveActivityEvent`.

### 2. Authoritative Generation [MODIFY]
#### [CompetitiveEventObserver](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/notifications/services/competitive_event_observer.dart)
- Update `_emitEvent` to assign appropriate `visibility` to generated activities.
- Ensure `deduplicationKey` is consistently used as the document ID for idempotency.
- Map specific event types to visibility (e.g., Rank Up -> Friends/Public, Achievement -> Friends/Public).

### 3. Data & Repository [MODIFY]
#### [FirebaseActivityRepository](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/data/repositories/firebase_activity_repository.dart)
- Update `getSocialActivityFeed` to filter by `visibility`.
- Implement basic "blocked user" filtering logic in the repository (though primarily enforced by rules).

### 4. Security Rules [MODIFY]
#### [firestore.rules](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/firestore.rules)
- **Harden `competitive_activity` subcollection**:
    - `allow create`: Verify `isOwner(userId)` AND use `existsAfter` to verify the `referenceId` exists in the authoritative collection (Achievements, Rank History, etc.).
    - `allow read`: Enforce visibility. A user can read another's activity if:
        - Visibility is `public`.
        - Visibility is `friends` AND `isFriend(request.auth.uid, targetUserId)`.
    - `allow delete`: Only `isOwner(userId)` or `isAdmin()`.
    - **Block Check**: Ensure `!isBlocked(request.auth.uid, targetUserId)`.

### 5. UI Integration [MODIFY]
#### [SocialActivityFeed](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/social/presentation/widgets/social_activity_feed.dart)
- Enhance the feed to handle empty, loading, and error states.
- Ensure compliance with the Premium Dark Theme and Material 3.
- Use `CompetitiveActivityCard` for presentation.

## Verification Plan

### Automated Tests
- **Domain Tests**: Verify `CompetitiveActivityEvent` serialization and visibility logic.
- **Observer Tests**: Ensure `CompetitiveEventObserver` generates activities with correct IDs and visibility.
- **Repository Tests**: Test feed aggregation and pagination.
- **Security Rule Tests**: (Requires Firebase Emulator) Verify that clients cannot forge activities or see private/blocked content.

### Manual Verification
- **Developer Preview**: Use `activity_previews.dart` to verify UI states:
    - Mixed activity feed (Rank, Achievement, Level).
    - Empty state.
    - Loading state.
    - Pagination (Load More).
- **Social Graph Check**: Verify that removing a friend immediately stops their activity from appearing in the feed.
- **Privacy Check**: Verify that a "Private" activity is only visible to the owner.
