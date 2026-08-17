# Fix "Error loading wallet" on Rewards Screen

The error is caused by a type mismatch when parsing Firestore data into the `Wallet` model. Firestore stores `DateTime` fields as `Timestamp` objects, but the generated `Wallet.fromJson` expects them as `String` (ISO 8601). When the repository passes the raw Firestore map to `fromJson`, it throws an exception, leading to the "Error loading wallet" state in the UI.

## Proposed Changes

### Economy Feature

#### [MODIFY] [firestore_wallet_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/rewards/data/repositories/firestore_wallet_repository.dart)

- Update `getWallet` and `watchWallet` to convert `Timestamp` fields (`updatedAt`, `proExpiresAt`) to ISO 8601 strings before parsing with `Wallet.fromJson`.
- Add a private helper method `_mapFirestoreToWallet` to handle this conversion consistently.

## Verification Plan

### Automated Tests
- I will check if I can run a unit test for the repository with mocked Firestore data containing Timestamps.

### Manual Verification
- Deploy the app and navigate to the Rewards screen.
- Verify that the wallet balance loads correctly and the red error message is gone.
- Ensure the top-right coin balance reflects the actual wallet data.
