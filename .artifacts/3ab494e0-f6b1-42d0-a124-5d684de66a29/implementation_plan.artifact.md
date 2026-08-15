# Riverpod 3.x Migration Plan - Phase 2

This plan addresses the remaining build errors after the initial migration.

## Proposed Changes

### Legacy API Support (Missing files)
- Add `import 'package:flutter_riverpod/legacy.dart';` to:
    - `lib/features/gameplay_engine/providers/competitive_gameplay_providers.dart`
    - `lib/features/tournaments/presentation/providers/tournament_gameplay_provider.dart`
    - `lib/features/social/preview/social_previews.dart`

### Family Notifier Fix
#### [MODIFY] [challenge_lobby_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/providers/challenge_lobby_providers.dart)
- Capture the family argument in the `build` method.
- Update `NotifierProvider.family` declaration to use the correct closure signature.

### StreamProvider Fix
#### [MODIFY] [personal_record_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/providers/personal_record_providers.dart)
- Use `.future` or correctly watch the `StreamProvider` to satisfy type constraints.

### Screen Fixes
#### [MODIFY] [event_gameplay_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/event_gameplay_screen.dart)
- Import `GameState`.
- Fix `ref.listen` type parameter.

## Verification Plan

### Automated Tests
- Run `flutter build apk --debug` to verify the build succeeds.
