# UI Compactness and Premium Polish Plan

Thorough analysis of the bottom navigation tabs and main screen layouts to achieve a more compact, premium, and well-proportioned UI.

## User Review Required

> [!NOTE]
> The changes focus on reducing vertical white space and tightening up component proportions. This will result in more content being visible on the screen at once without excessive scrolling.

## Proposed Changes

### Core Design System & Widgets

#### [MODIFY] [soteria_bottom_nav_bar.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/widgets/navigation/soteria_bottom_nav_bar.dart)
- Reduce vertical padding of the bottom nav bar.
- Decrease icon sizes slightly (28.sp -> 24.sp for normal, 24.sp -> 20.sp for short screens).
- Tighten spacing between icon and selection indicator.
- Adjust the floating bar's overall height and bottom margin.

---

### Dashboard Feature

#### [MODIFY] [dashboard_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/screens/dashboard_screen.dart)
- Reduce section spacing from `32.h` to `24.h` or `20.h`.
- Tighten top header and hero card spacing.
- Optimize the bottom sliver padding to be more precise for the floating nav bar.

#### [MODIFY] [dashboard_header.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/widgets/dashboard_header.dart)
- Adjust avatar and text proportions for a more compact header.

#### [MODIFY] [quick_actions_grid.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/widgets/quick_actions_grid.dart)
- Reduce internal padding and grid spacing if necessary.

---

### Player Feature

#### [MODIFY] [leaderboard_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/leaderboard_screen.dart)
- Reduce top padding and list item heights.
- Tighten the podium layout.

#### [MODIFY] [player_profile_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/player_profile_screen.dart)
- Reduce spacing between sections (e.g., `xlStatic` -> `lgStatic`).
- Make the header more compact by reducing avatar size slightly.

---

### Shared Components

#### [MODIFY] [soteria_card.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/design_system/components/soteria_card.dart)
- Ensure card padding is balanced and not overly generous.

## Verification Plan

### Automated Tests
- Run existing UI tests to ensure no regressions in functionality.
- `flutter test`

### Manual Verification
- Deploy to an emulator/device and verify the visual proportions across different screen sizes.
- Check that the bottom navigation bar doesn't obscure content or look too cramped.
- Verify that the Dashboard, Leaderboard, and Profile screens feel more "premium" and compact.
