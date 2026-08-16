# Bug Fix: Daily Rewards Claim Reversion

The user reported that claiming the daily reward adds 100 coins but then reverts (coins are removed and the button state resets to "Claim"). This is likely caused by the `DailyBonusNotifier` being re-initialized when the user profile updates, losing its "claiming" state and briefly showing stale data before the Firestore update fully propagates. Additionally, the UI might be showing default values (0 coins) during brief loading states.

## Proposed Changes

### Dashboard Component

#### [MODIFY] [daily_bonus_provider.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/providers/daily_bonus_provider.dart)
- Update `DailyBonusNotifier.build()` to preserve the `isClaiming` state if a re-initialization occurs during an active claim.
- Ensure that if the player data is briefly `null` during a stream update, the previous `lastClaimTime` is maintained to avoid the "canClaim" button flickering back to true.

#### [MODIFY] [dashboard_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/screens/dashboard_screen.dart)
- Update the `DashboardHeader` loading state to avoid resetting coins to 0. It should ideally show the last known values or a loading shimmer that doesn't imply a balance of 0.

### Player Component

#### [MODIFY] [player_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/providers/player_providers.dart)
- Ensure `currentPlayerProvider` uses `ref.watch(currentPlayerStreamProvider).maybeWhen(data: (d, _) => d, orElse: () => null)` or similar to avoid returning `null` when a stream is simply refreshing its data but already has a value.

## Verification Plan

### Manual Verification
- Deploy the app and trigger the daily reward claim.
- Observe the coin balance and the "Claim" button state.
- Verify that the button stays in the "Claimed" (or disabled) state and the coin balance does not flicker back to the previous value or zero.
