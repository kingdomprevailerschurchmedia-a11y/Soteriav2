# Fix Firestore Permission Denied on Pro Mode Initialization

The user is experiencing a `PERMISSION_DENIED` error when trying to start a Pro Mode session. This is caused by two main issues in the Firestore security rules and the repository implementation:

1.  **Strict Read Rules**: Several collections (`competitive_sessions`, `pro_reservations`, `pro_results`, `practice_sessions`) have read rules that require `resource.data.uid == request.auth.uid`. When the app tries to check if a document exists (e.g., a new reservation or session), Firestore denies the read because the non-existent document doesn't have a `uid` field, instead of allowing the app to see that it doesn't exist.
2.  **Incomplete Coin Transaction Integrity**: The `users` and `wallets` collection rules require updating `lastCoinTransactionId` whenever the `coins` balance changes. The `FirestoreProModeRepository` updates the coin balance in `reserveEntryFee` and `refundEntryFee` but fails to update the transaction tracking IDs, leading to a rule violation.

## Proposed Changes

### [Firebase]

#### [MODIFY] [firestore.rules](file:///C:/Users/smile/Soteriav2/firebase/firestore.rules)
- Update read rules for `competitive_sessions`, `pro_reservations`, `pro_results`, `practice_sessions`, and `public_profiles` to include `resource == null`. This allows the client to perform `get()` requests on documents that don't yet exist (returning `exists: false`) without triggering a permission error.
- Add `resource == null` to `match /users/{userId}` read rule for consistency, although it's currently open to authenticated users.

### [Gameplay Engine]

#### [MODIFY] [firestore_pro_mode_repository.dart](file:///C:/Users/smile/Soteriav2/lib/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart)
- In `reserveEntryFee`:
    - Ensure `lastCoinTransactionId` is updated on the `users` document when coins are changed.
    - Ensure `lastTransactionId` is updated on the `wallets` document.
    - Simplify the coin update logic to satisfy the security rule which expects the coin change to match exactly one transaction record in the final state of the atomic transaction.
- In `refundEntryFee`:
    - Update `lastCoinTransactionId` on `users` and `lastTransactionId` on `wallets`.
- In `completeSession`:
    - Ensure all sync points (Wallet, Game Profile) follow the transaction integrity rules.

## Verification Plan

### Automated Tests
- I will attempt to run existing tests for Pro Mode if available.
- I will verify the Firestore rules using a local simulator if configured, or by manual verification via the app.

### Manual Verification
- Deploy the updated Firestore rules.
- Test "Pro Mode" initialization in the app to ensure the "SYSTEM ERROR" no longer appears.
- Verify that coin balances are correctly updated and transaction records are created.
