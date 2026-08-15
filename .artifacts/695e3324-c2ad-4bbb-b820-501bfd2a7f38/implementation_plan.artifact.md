# Fix "Player profile not found" Error and Collection Inconsistency

The app is currently using two different Firestore collections for user/player profiles: `users` and `players`. `FirestorePlayerRepository` (used for bootstrapping and profile management) uses `users`, while `FirestoreProModeRepository` and several other repositories use `players`. This inconsistency causes errors when the app expects a document in `players` that hasn't been created or migrated.

The screenshot shows a "SYSTEM ERROR: Exception: Player profile not found." which is specifically thrown by `FirestoreProModeRepository` when it cannot find a user in the `players` collection.

## Proposed Changes

### Component: Repositories

#### [MODIFY] [firestore_pro_mode_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart)
- Update all occurrences of `collection('players')` to `collection('users')`.

#### [MODIFY] [firestore_competitive_settlement_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/gameplay_engine/data/repositories/firestore_competitive_settlement_repository.dart)
- Update `collection('players')` to `collection('users')`.

#### [MODIFY] [firestore_competitive_stats_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/gameplay_engine/data/repositories/firestore_competitive_stats_repository.dart)
- Update `collection('players')` to `collection('users')`.

#### [MODIFY] [firestore_tournament_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/tournaments/data/repositories/firestore_tournament_repository.dart)
- Update `collection('players')` to `collection('users')`.

### Component: Services

#### [MODIFY] [player_bootstrap_service.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/services/player_bootstrap_service.dart)
- Remove the legacy migration logic that checks the `players` collection, as we are standardizing on `users`.

### Component: Notifiers

#### [MODIFY] [pro_lobby_providers.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/dashboard/presentation/providers/pro_lobby_providers.dart)
- Add error handling to `_updateValidation` and `_checkAvailability` to prevent unhandled exceptions from crashing the lobby UI.

## Verification Plan

### Automated Tests
- Run existing unit tests for `ProLobbyNotifier` and `FirestoreProModeRepository` to ensure they still work with the `users` collection.

### Manual Verification
1. Navigate to the Practice Lobby.
2. Navigate to the Pro Mode Lobby.
3. Start a practice session and a pro mode session.
4. Verify that coins and stats are updated correctly in the `users` collection.
