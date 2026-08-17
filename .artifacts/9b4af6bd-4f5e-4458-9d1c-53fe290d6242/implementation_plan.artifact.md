# Redesign Hero Card Rank and Streak

Redesign the "Current Rank" and "Streak" sections in the dashboard's `HeroCard` to match the provided UI design. This includes removing the rank badge, repositioning text, and updating the streak widget's appearance.

## User Review Required

> [!IMPORTANT]
> The font size for the rank name has been increased significantly to match the "large" appearance in the reference image. Please verify if the scaling is appropriate for all device sizes.

## Proposed Changes

### Dashboard Feature

#### [MODIFY] [hero_card.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/widgets/hero_card.dart)
- Remove `CompetitiveRankBadge` from the top row of the `HeroCard`.
- Update "CURRENT RANK" label styling:
    - Change color to `white.withOpacity(0.5)`.
    - Adjust font weight and spacing.
- Update Rank Name text styling:
    - Change from all-caps gold to title-case white.
    - Increase font size to `32.sp`.
    - Set font weight to `FontWeight.bold`.
- Redesign `_StreakSummary` widget:
    - Change container to a pill-shape (high border radius).
    - Add a border and subtle background.
    - Replace the `progress/7` logic with a simple `streak Streak` display.
    - Add a fire icon and a vertical divider.

## Verification Plan

### Manual Verification
- Deploy the app to an emulator/device.
- Navigate to the dashboard.
- Verify the `HeroCard` top section:
    - "CURRENT RANK" label is small and greyish.
    - Rank name (e.g., "Unranked") is large, white, and bold.
    - No rank badge is visible.
    - Streak widget on the right is pill-shaped with a fire icon, divider, and streak count.
