# Competitive Rewards & Economy Integrity Plan

Implement the Soteria competitive reward economy for Pro, Versus, and Tournament modes with authoritative settlement and transaction integrity.

## User Review Required

> [!IMPORTANT]
> The reward multipliers and base values have been explicitly defined in the story. I will centralize these in a `CompetitiveRewardConfig`.
>
> XP and Coins will be updated across `users`, `wallets`, and `player_progression` collections to maintain consistency with the current architecture, but I will ensure this happens within atomic Firestore transactions.

## Open Questions

- None at this stage. I have enough information from the story and the audit.

## Proposed Changes

### Configuration Layer

#### [NEW] [competitive_reward_config.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/domain/config/competitive_reward_config.dart)
Authoritative configuration for all mode rewards, entry fees, and accuracy multipliers.

### Domain Models & Logic

#### [MODIFY] [competitive_settlement.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/models/competitive_settlement.dart)
Add fields for tournament rewards and platform fees if missing.

#### [NEW] [reward_settlement_service.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/domain/services/reward_settlement_service.dart)
Central service to calculate authoritative rewards (XP, Coins, RP) based on game results and mode configuration.

### Repositories (Settlement Implementation)

#### [MODIFY] [firestore_competitive_settlement_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/data/repositories/firestore_competitive_settlement_repository.dart)
Update to use `RewardSettlementService` for calculations and ensure idempotency.

#### [MODIFY] [firestore_pro_mode_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart)
Refactor `completeSession` to delegate reward calculation to the new service and use the centralized configuration.

#### [NEW] [firestore_tournament_reward_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/tournaments/data/repositories/firestore_tournament_reward_repository.dart)
Implement tournament-specific reward settlement.

### Security & Integrity

#### [MODIFY] [firestore.rules](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/firebase/firestore.rules)
Harden rules for `xp_transactions` and `coin_transactions` to prevent unauthorized client-side creation. Ensure only the server (or a trusted transaction pattern) can update economic fields.

## Verification Plan

### Automated Tests
- `reward_settlement_service_test.dart`: Test all Pro Mode difficulty/question tiers and accuracy multipliers.
- `versus_reward_test.dart`: Test 500/1000/5000 wagers and platform fee calculations.
- `tournament_reward_test.dart`: Test placement-based reward distribution.
- `idempotency_test.dart`: Verify that duplicate settlement calls do not double-grant rewards.

### Manual Verification
- Verify that the Store, Earn, and History tabs correctly reflect new transactions.
- Check the Post-Game Summary screen for accurate reward display.
