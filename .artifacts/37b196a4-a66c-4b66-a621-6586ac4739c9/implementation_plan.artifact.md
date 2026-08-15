# Build Error Fixes Plan

Fix multiple compilation errors in the Soteria project including missing imports, incorrect provider usage, and widget signature mismatches.

## Proposed Changes

### [features/player]

#### [MODIFY] [goal_details_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/goal_details_screen.dart)
- Update `build` method signature to `Widget build(BuildContext context, WidgetRef ref)`.

#### [MODIFY] [competitive_season_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/competitive_season_screen.dart)
- Pass `season.seasonId` to `leaderboardControllerProvider`.

#### [MODIFY] [goal_selection_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/goal_selection_screen.dart)
- Change `border: Border.all(...)` to `side: BorderSide(color: SoteriaColors.border)` in `RoundedRectangleBorder`.

#### [MODIFY] [goal_history_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/screens/goal_history_screen.dart)
- Change `border: Border.all(...)` to `side: BorderSide(color: SoteriaColors.border)` in `RoundedRectangleBorder`.

---

### [features/dashboard]

#### [MODIFY] [practice_lobby_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/screens/practice_lobby_screen.dart)
- Add import for `lobby_config_widgets.dart`.

---

### [features/gameplay_engine]

#### [MODIFY] [game_engine_provider.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/providers/game_engine_provider.dart)
- Add import for `identity_providers.dart`.

#### [MODIFY] [progression_policy.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/progression/models/progression_policy.dart)
- Add `GameMode get mode;` to `ProgressionPolicy` interface and implementations.

## Verification Plan

### Automated Tests
- Run `flutter build apk` or `flutter run` to verify that all compilation errors are resolved.
