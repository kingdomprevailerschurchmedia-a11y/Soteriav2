# Soteria Onboarding Redesign Plan

Redesign the onboarding screen to match a premium reference design while preserving existing business logic and assets.

## User Review Required

> [!IMPORTANT]
> The current onboarding uses `Icons` as placeholders. I will replace these with the existing asset illustrations found in `assets/images/`. Based on the file listing, I will use `assets/images/file_000000009e3c81f4af74b474d358f8b5.png` as the primary rocket illustration.

> [!NOTE]
> I will implement a responsive layout using `LayoutBuilder` and `SoteriaResponsive` to ensure the design works across all device sizes without unnecessary scrolling.

## Proposed Changes

### Onboarding Feature

#### [MODIFY] [onboarding_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/onboarding/screens/onboarding_screen.dart)
- Redesign the overall layout to match the reference composition.
- Implement the premium dark background with cosmic atmosphere.
- Update `PageView` to use the new illustration assets.
- Implement the multi-color headline "Compete. Learn. Rise." using `RichText`.
- Replace existing buttons with the new premium glowing NEXT button and minimal SKIP button.
- Ensure `SafeArea` and responsive padding are applied.

#### [MODIFY] [onboarding_page.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/onboarding/widgets/onboarding_page.dart)
- Update to handle the new responsive layout requirements.
- Remove `SingleChildScrollView` to prevent unnecessary scrolling, while allowing it for large text accessibility.
- Improve illustration transitions (parallax/scale).

#### [MODIFY] [onboarding_indicator.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/onboarding/widgets/onboarding_indicator.dart)
- Redesign dots to match the reference: gold for active, purple for inactive.
- Implement smooth transitions between active states.

### Design System

#### [NEW] [onboarding_button.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/onboarding/widgets/onboarding_button.dart)
- Create a specific premium button for the onboarding flow with neon borders and glass effects.

### Previews & Testing

#### [MODIFY] [onboarding_preview_page.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/preview_gallery/pages/onboarding_preview_page.dart)
- Update previews to include all onboarding states and device configurations.

#### [MODIFY] [onboarding_screen_test.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/test/features/onboarding/onboarding_screen_test.dart)
- Update Golden Tests and widget tests to reflect the new UI.

## Verification Plan

### Automated Tests
- Run `flutter test test/features/onboarding/onboarding_screen_test.dart`
- Run `flutter analyze`

### Manual Verification
- Launch the app and verify the onboarding flow on multiple emulators (Small Phone, Large Phone, Tablet).
- Verify landscape orientation.
- Verify accessibility text scaling.
- Use the Developer Preview System to inspect specific states.
