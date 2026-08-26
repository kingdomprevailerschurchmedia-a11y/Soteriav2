# Fix Daily Reward Claim Logic

The Daily Login Reward is currently missing from the Rewards screen because it is not being explicitly injected into the list of available rewards in the provider, and the repository does not include it by default.

## Proposed Changes

### Rewards Feature

#### [MODIFY] [rewards_providers.dart](file:///C:/Joseph Project/Soteria/lib/features/rewards/presentation/providers/rewards_providers.dart)

- Update `availableRewardsProvider` to explicitly prepend the Daily Login Reward (`reward_daily_1`) to the list of rewards fetched from the repository.
- Ensure the Daily Login Reward status is correctly derived from the `dailyBonusProvider` state.

## Verification Plan

### Manual Verification
- Deploy the app to a device/emulator.
- Navigate to the **Rewards** screen.
- Verify that the **Daily Login Reward** appears at the top of the **Earn** tab.
- Attempt to claim the reward and verify:
    - The button shows a loading spinner during the claim process.
    - The coin balance updates in the header.
    - The reward status changes to "Claimed" with a checkmark.
    - The reward stays claimed for the remainder of the day.
