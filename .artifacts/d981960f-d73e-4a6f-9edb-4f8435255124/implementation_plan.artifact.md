# Fix Firestore Permission Denied Error in Pro Mode Lobby

The app currently fails to initialize a Pro Mode session with a `PERMISSION_DENIED` error. This is caused by missing security rules for several critical collections and overly restrictive rules for coin/wallet transactions.

## User Review Required

> [!IMPORTANT]
> The updated security rules will grant read access to the `questions` and `categories` collections to all authenticated users. This is necessary for the lobby to function but ensures content is publicly readable by players.

## Proposed Changes

### Firebase Security Rules

#### [MODIFY] [firestore.rules](file:///C:/Joseph Project/Soteria/firebase/firestore.rules)
- Add read access for authenticated users to `questions`, `categories`, `subcategories`, and `topics` collections.
- Relax the `users` and `wallets` update rules to allow for composite coin changes (refund + spend) during Pro Mode session initialization.
- Ensure `competitive_sessions` and `pro_reservations` rules correctly handle ownership checks for queries.

### Gameplay Engine Data Layer

#### [MODIFY] [firestore_pro_mode_repository.dart](file:///C:/Joseph Project/Soteria/lib/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart)
- Ensure that if multiple coin changes occur (e.g., refund + spend), they are handled in a way that remains compatible with the security rules, or that the rules are updated to accommodate the batch update.

## Verification Plan

### Manual Verification
1. Deploy the updated Firestore rules via the Firebase CLI (or simulate in the emulator).
2. Open the Soteria app and navigate to the **Pro Mode Lobby**.
3. Configure a session and tap **INITIALIZE SESSION**.
4. Verify that the session is successfully created and the app navigates to the gameplay screen without the "SYSTEM ERROR" overlay.
