# UI Compactness Optimization Plan

Thoroughly analyze and optimize the Profile and Settings screens to achieve a more compact, dashboard-aligned layout. This involves reducing text sizes, icon scales, and vertical spacing to prevent overlapping and excessive scrolling.

## Proposed Changes

### [Component] Player Profile

#### [MODIFY] [player_profile_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/screens/player_profile_screen.dart)
- Reduce "Profile" title from `34.sp` to `26.sp`.
- Reduce display name from `26.sp` to `20.sp`.
- Reduce avatar size from `100.w` to `80.w`.
- Tighten section spacing from `32.h` to `20.h`.
- Reduce vertical padding in `_AccountTile` from `8` to `4`.

#### [MODIFY] [player_progression_card.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/widgets/player_progression_card.dart)
- Reduce card padding from `24.w` to `16.w`.
- Reduce XP/Rank value text from `28.sp` to `22.sp`.
- Reduce Hexagon icon size from `60.w` to `48.w`.

---

### [Component] Competitive Profile

#### [MODIFY] [competitive_profile_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/screens/competitive_profile_screen.dart)
- Replace `SoteriaSpacing.xxl` (48) with `SoteriaSpacing.lg` (24) or `xl` (32) for section gaps.
- Adjust `_buildStatsGrid` childAspectRatio from `2.2` to `2.6` for a shorter, more compact look.

#### [MODIFY] [statistic_card.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/widgets/profile/statistic_card.dart)
- Reduce padding from `SoteriaSpacing.md` (16) to `SoteriaSpacing.sm` (8).
- Reduce icon size from `20` to `18`.

#### [MODIFY] [career_summary_card.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/widgets/profile/career_summary_card.dart)
- Reduce value text from `titleLarge` to `titleMedium`.
- Increase `childAspectRatio` from `2.5` to `3.0` for more horizontal density.

---

### [Component] Settings

#### [MODIFY] [settings_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/settings/screens/settings_screen.dart)
- Reduce section gap from `32.h` to `20.h`.
- Reduce `_SettingsItem` vertical padding from `8` to `4`.
- Reduce logout section vertical padding from `16` to `12`.

## Verification Plan

### Manual Verification
- Deploy to an Android device/emulator.
- Inspect Profile screen for overlapping elements and overall density.
- Compare layout density with the Dashboard screen to ensure consistency.
- Check Settings screen on small screen sizes to ensure all items are visible without excessive scrolling.
