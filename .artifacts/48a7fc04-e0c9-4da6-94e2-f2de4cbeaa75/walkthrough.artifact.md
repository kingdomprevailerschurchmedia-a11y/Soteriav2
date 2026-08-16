# Walkthrough - Story 11.11 Social Activity

Implemented a secure, scalable Social Activity system for Soteria. The system surfacing authoritative competitive milestones to a player's social graph while respecting privacy and security boundaries.

## Changes Made

### Core Domain & Data
- **Unified Activity Model**: Enhanced `CompetitiveActivityEvent` with an `ActivityVisibility` enum (`public`, `friends`, `private`).
- **Authoritative Observer**: Updated `CompetitiveEventObserver` to automatically generate activity events from progression, achievements, milestones, and new friendships.
- **Authoritative Integrity**: Hardened `firestore.rules` for the `competitive_activity` collection using `existsAfter` to verify that activity records correspond to legitimate authoritative documents (e.g., rank transactions, achievement unlocks).
- **Social Graph Integration**: Integrated with the Story 11.10 `friendships` and `blocks` collections to enforce visibility and privacy.
- **Scalable Repository**: Updated `FirebaseActivityRepository` to handle activity feeds across a social graph (up to 30 friends) using `collectionGroup` queries.

### UI & Presentation
- **Standardized Feed**: Migrated `SocialActivityFeed` to use `CompetitiveActivityEvent` and the premium `CompetitiveActivityCard`.
- **New Activity Type**: Added support for `friendshipEstablished` events in the UI and domain.
- **Developer Preview**: Updated `SocialPreviews` and `ActivityPreviews` with mixed activity scenarios, including rank promotions, achievements, and new connections.

## Verification Results

### Automated Tests
- **Domain Tests**: Verified `CompetitiveActivityEvent` serialization and visibility defaults. (`test/features/social/social_activity_test.dart`)
- **Regression Tests**: Verified existing competitive activity tests. (`test/features/player/competitive_activity_test.dart`)
- **Analysis**: `flutter analyze` passed for all modified files (unrelated legacy issues remain in the bin/ and some other test files).

### Security & Privacy
- Verified that `firestore.rules` correctly block unauthorized read/write access to activity records.
- Verified that blocked users cannot see activity from the blocker.
- Verified that "Private" activity is only accessible to the owner.

### Idempotency
- Verified that `deduplicationKey` prevents duplicate activity entries for the same authoritative event.

## Technical Debt / Follow-up
- **Redundant Model**: `SocialActivityEvent` in `lib/features/social` is now redundant and should be deleted once all legacy references (if any remain in local developer branches) are cleared.
- **Spark Limitations**: Feed size remains limited to 30 friends due to Firestore `whereIn` constraints. Aggregation for larger social graphs would require a flat root collection or a paid Blaze-tier solution (Cloud Functions).
