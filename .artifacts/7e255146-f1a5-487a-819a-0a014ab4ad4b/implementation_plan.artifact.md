# Implementation Plan - Compact & Premium Selection Cards

This plan aims to make the selection cards (referred to by the user as "tabs") in the Personalization screen more compact and premium-looking, as per the provided reference image.

## User Review Required

> [!NOTE]
> The vertical padding of the cards will be reduced to create a more compact "classic" feel. The icon container and text sizes will also be slightly adjusted to maintain visual balance in the smaller height.

## Proposed Changes

### Personalization Feature

#### [MODIFY] [selection_card.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/personalization/widgets/selection_card.dart)
- Reduce vertical padding from `20.h` to `12.h`.
- Reduce horizontal padding from `20.w` to `16.w`.
- Shrink the icon container from `56.w` to `48.w` to fit the more compact height.
- Update the border radius of the main card and icon container for a more refined look.
- Tweak text sizes slightly (`18.sp` -> `16.sp` for title, `13.sp` -> `12.sp` for subtitle) to improve the compact feel.
- Adjust the trailing icon container size from `32.w` to `28.w`.

## Verification Plan

### Manual Verification
- Deploy the app to a device or emulator.
- Navigate to the Personalization screen.
- Verify that the selection cards (Academic Level, etc.) are more compact vertically.
- Compare the new look with the provided reference image to ensure it feels "premium and classic".
- Ensure the selection state (gold border/glow) still looks correct.
