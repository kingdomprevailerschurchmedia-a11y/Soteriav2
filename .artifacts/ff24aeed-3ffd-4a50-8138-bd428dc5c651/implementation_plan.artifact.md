# Story 11.10 — Friends / Social Connections

Implement and certify a production-ready social connection system by hardening the existing social infrastructure.

## User Review Required

> [!IMPORTANT]
> The system uses deterministic IDs for friendships (`min(id1, id2)_max(id1, id2)`) and friend requests (`senderId_receiverId`). This ensures uniqueness and prevents duplicate relationships at the data layer.

## Proposed Changes

### Social Feature Hardening

#### [MODIFY] [firebase_social_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/data/repositories/firebase_social_repository.dart)
- Add self-friendship prevention in `sendFriendRequest`.
- Use a transaction in `acceptFriendRequest` to ensure atomicity and prevent race conditions.
- Add checks to prevent sending duplicate requests or requests to existing friends.
- Ensure all operations are idempotent.

#### [MODIFY] [firestore.rules](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/firestore.rules)
- Add granular security rules for `friend_requests`, `friendships`, `blocks`, and `follows`.
- Restrict write access to owners and recipients.
- Enforce state transition constraints (e.g., only recipient can accept).

### Player Discovery & UI Integration

#### [MODIFY] [player_search_result_card.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/widgets/search/player_search_result_card.dart)
- Integrate with `relationshipStatusProvider` to show "Add Friend", "Pending", or "Friends" status.
- Add actions to send friend requests directly from search results.

#### [MODIFY] [friends_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/presentation/screens/friends_screen.dart)
- Verify empty states and error handling.
- Ensure "Remove Friend" functionality is correctly wired.

### Testing & Verification

#### [NEW] [social_repository_test.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/test/features/social/social_repository_test.dart)
- Test friend request lifecycle: Send -> Accept -> Friends.
- Test rejection and cancellation.
- Test self-friendship prevention.
- Test duplicate request prevention.
- Test concurrency and idempotency.

#### [MODIFY] [social_previews.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/social/preview/social_previews.dart)
- Add scenarios for:
    - Loading states.
    - Error states (e.g., permission denied).
    - Self-search (no "Add Friend" button).
    - Different relationship statuses in search.

## Verification Plan

### Automated Tests
- Run `flutter test test/features/social/social_repository_test.dart`
- Run `flutter analyze`

### Manual Verification
- Use Developer Preview to verify all UI states.
- Verify relationship transitions in the app.
- Verify Firestore rules using the Emulator.
