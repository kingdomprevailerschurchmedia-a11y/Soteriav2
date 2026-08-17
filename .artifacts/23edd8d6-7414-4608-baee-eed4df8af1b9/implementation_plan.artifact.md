# Implementation Plan - Replace Unranked Icon with PNG Badge

Update the dashboard's rank display to use the specific `unranked_badge.png` asset for unranked players, ensuring a premium visual experience that matches the design system requirements.

## Proposed Changes

### [Player Widgets]

#### [MODIFY] [competitive_rank_badge.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/competitive_rank_badge.dart)
- Update the `build` method to intercept the 'unranked' tier and return the `unranked_badge.png` asset directly.
- This ensures the PNG is used as the primary visual for unranked players, bypassing the standard vector-based ring and star decorations which are intended for ranked tiers.
- Add support for `tierId == 'none'` to handle legacy or preview states.

#### [MODIFY] [rank_badge.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/rank_badge.dart)
- Update the fallback icon for unranked players to be more consistent if needed, or simply ensure it doesn't conflict with the new PNG visual in other areas. (Optional but good for consistency).

### [Dashboard Feature]

#### [MODIFY] [hero_card.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/widgets/hero_card.dart)
- Verify that the `CompetitiveRankBadge` is correctly receiving the 'unranked' status.

## Verification Plan

### Manual Verification
- Deploy to device/emulator.
- Log in with a player who has 0 RP (Unranked).
- Verify the `HeroCard` on the Dashboard shows the `unranked_badge.png` asset.
- Verify that the asset scales correctly according to the `RankBadgeSize`.
