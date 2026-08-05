# Implementation Plan - Fix Terminal Errors (Test Failures)

Several errors were identified in the terminal output when running `flutter test`. This plan addresses UI layout issues, test configuration gaps, and logic bugs in the gameplay engine.

## User Review Required

> [!IMPORTANT]
> The Firebase initialization errors in tests are caused by the code attempting to initialize real Firebase instead of using a mock. I will implement a mocking strategy for `FirebaseBootstrapper` in the test environment.
>
> The `SoteriaLoader` widget expected in `widget_test.dart` is not present on the `SplashScreen`. I will update the test to match the actual splash screen UI.

## Proposed Changes

### UI & Layout

#### [MODIFY] [auth_provider_button.dart](file:///C:/Joseph%20Project/lib/features/auth/widgets/auth_provider_button.dart)
- Wrap the `Text` widget inside the `Row` with `Flexible` to prevent `RenderFlex` overflow errors when the provider name is long.

### Test Configuration

#### [MODIFY] [navigation_coordinator_test.dart](file:///C:/Joseph%20Project/test/core/navigation/navigation_coordinator_test.dart)
- Add `TestWidgetsFlutterBinding.ensureInitialized()` to the `main` or `setUp` to allow `HapticFeedback` to be called during tests without crashing.

#### [MODIFY] [navigation_test.dart](file:///C:/Joseph%20Project/test/navigation_test.dart)
- Override `firebaseBootstrapperProvider` in the `ProviderContainer` to use a mock bootstrapper that doesn't attempt real Firebase initialization.

#### [MODIFY] [widget_test.dart](file:///C:/Joseph%20Project/test/widget_test.dart)
- Update the test assertions to look for the correct splash screen components (logo, branding text) instead of the non-existent `SoteriaLoader`.
- Add Firebase mocking to prevent initialization failures.

### Gameplay Engine Logic

#### [MODIFY] [game_engine_test.dart](file:///C:/Joseph%20Project/test/features/gameplay_engine/game_engine_test.dart)
- Update the `GameEngine` instantiation in `setUp` to include a `ProgressionNotifier`. Currently, it is passed as `null`, which causes the score to remain at 0 even after correct answers.

## Verification Plan

### Automated Tests
- Run `flutter test` and verify that all previously failing tests now pass:
  - `test/core/navigation/navigation_coordinator_test.dart`
  - `test/features/auth/auth_landing_screen_test.dart`
  - `test/features/gameplay_engine/game_engine_test.dart`
  - `test/navigation_test.dart`
  - `test/widget_test.dart`

### Manual Verification
- Verify the `AuthProviderButton` layout visually if possible (though the test failure is a clear indicator of the bug).
