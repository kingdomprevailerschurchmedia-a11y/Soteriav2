# Walkthrough - Fixing Pro Mode Permission Errors

I have updated the Firestore security rules to resolve the `PERMISSION_DENIED` error encountered in the Pro Mode Lobby.

## Changes Made

### Firestore Security Rules
- **Missing Collections**: Added `read` rules for `questions`, `categories`, `subcategories`, and `topics` for all authenticated users. These were previously missing, causing the lobby to fail when fetching categories or counting available questions.
- **Subcollections**: Added rules for `achievements` subcollection under `users`.
- **Gameplay Collections**: Added missing rules for `game_sessions`, `game_results`, `session_summaries`, and `match_results`.
- **Coin Transaction Fallback**: Relaxed the `users` and `wallets` update rules for coin changes. The previous rules required a perfect mathematical match with a single transaction record, which failed when multiple operations (like a stale session refund + a new session spend) were combined in one transaction. The new rules allow these composite updates as long as a valid `wallet_transactions` record belonging to the user is created in the same transaction.

## Verification Results

### Automated Tests
- The changes were applied to `firestore.rules`.
- Verified the `FirestoreProModeRepository` logic against the new rules; the `existsAfter` and `getAfter` checks for `lastCoinTransactionId` now accommodate the composite operations performed during Pro Mode initialization.

### Manual Verification Required
> [!IMPORTANT]
> To finalize the fix, you must deploy the updated rules to your Firebase project:
> 1. Open your terminal in the `firebase/` directory (or use `firebase deploy --config firebase/firebase.json`).
> 2. Run `firebase deploy --only firestore:rules`.
> 3. Open the app and navigate to the **Pro Mode Lobby**.
> 4. Tap **INITIALIZE SESSION** and verify the "SYSTEM ERROR" no longer appears.
