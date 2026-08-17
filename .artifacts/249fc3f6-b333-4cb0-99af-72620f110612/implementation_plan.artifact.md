# Bug Fix: Daily Reward Claim Failure for New Users

The user reported that claiming the daily reward shows a loading state and then reverts without adding coins, specifically for new users signed in via Google. Investigation suggests this is due to Firestore security rules blocking standard users from updating their own coin balances and wallet documents. Additionally, the use of `transaction.update` may fail if the user document hasn't been fully initialized.

## User Review Required

> [!IMPORTANT]
> The fix involves relaxing Firestore security rules to allow standard users to update their own coin balances and wallets directly from the client. While this is less secure than a backend-only approach, it matches the current client-side implementation of the rewards system.

## Proposed Changes

### Firestore Security Rules

#### [MODIFY] [firestore.rules](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/firestore.rules)
*   Allow `update` on `users/{userId}` for `coins`, `tokens`, and `lastDailyRewardClaim` if the user is the owner.
*   Allow `read` and `write` on `wallets/{userId}` if the user is the owner (currently only `isAdmin` can write).

### Dashboard Feature

#### [MODIFY] [daily_bonus_provider.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/dashboard/presentation/providers/daily_bonus_provider.dart)
*   Change `transaction.update(userRef, ...)` to `transaction.set(userRef, ..., SetOptions(merge: true))` to safely handle missing documents or fields.
*   Add `lastCoinTransactionId` to the user document update to link the transaction record.
*   Ensure the `isClaiming` state is handled correctly on success.

## Verification Plan

### Automated Tests
*   N/A (Requires live Firestore for full transaction test)

### Manual Verification
1.  Sign in as a new user with Google.
2.  Navigate to the Dashboard.
3.  Click "Claim" on the Daily Reward card.
4.  Verify that the button shows loading, then changes to "Claimed".
5.  Verify that coins are added to the balance in the header.
6.  Navigate to the Rewards -> History tab and verify the transaction is logged (Note: may require fixing collection names, but I will focus on the claim success first).
