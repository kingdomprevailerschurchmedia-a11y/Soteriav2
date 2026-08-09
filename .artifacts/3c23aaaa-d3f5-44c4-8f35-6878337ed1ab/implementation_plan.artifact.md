# Quiz Countdown Timer Implementation Plan

The objective is to implement a production-grade, deterministic, and absolute-deadline-based timer for the Soteria Quiz Engine.

## User Review Required

- **Timer State Ownership**: The timer logic will remain within `QuizController` but will be refactored to be cleaner and more deterministic using the `IClock` abstraction.
- **Background Policy**: We will adopt a "Pause Timer" policy when the app is in the background, to ensure fairness and prevent timer drift/cheating. This will be documented as the current baseline.
- **Race Condition Handling**: `QuizController` will enforce a strict "first-to-arrive" logic for answer submission and timeout expiration using atomic checks.

## Open Questions

- None at this time.

## Proposed Changes

### [Domain Layer]
- **[MODIFY]** [timer_state.dart](file:///C:/Users/kpc-m/AndroidStudioProjects/PROJECT/Soteria/lib/features/quiz/domain/models/timer_state.dart): Update fields to include more granular state (e.g., pause/resume readiness).

### [Presentation Layer - Controllers]
- **[MODIFY]** [quiz_controller.dart](file:///C:/Users/kpc-m/AndroidStudioProjects/PROJECT/Soteria/lib/features/quiz/presentation/controllers/quiz_controller.dart):
    - Implement absolute deadline-based calculation.
    - Refactor `_onTick` to be more robust.
    - Handle background lifecycle events (via state observation of app lifecycle).
    - Ensure strict state transitions to avoid race conditions.

### [Presentation Layer - Widgets]
- **[MODIFY]** [quiz_timer.dart](file:///C:/Users/kpc-m/AndroidStudioProjects/PROJECT/Soteria/lib/features/quiz/presentation/widgets/quiz_timer.dart):
    - Update to handle new `TimerState` enhancements.
    - Improve accessibility semantics.

### [Infrastructure/Utils]
- **[NEW]** [fake_clock.dart](file:///C:/Users/kpc-m/AndroidStudioProjects/PROJECT/Soteria/lib/core/utils/fake_clock.dart): Implementation of `IClock` for deterministic testing.

## Verification Plan

### Automated Tests
- Unit tests for `QuizController` using `FakeClock` to verify timer behavior under various conditions (start, stop, timeout, concurrent answer submission).

### Manual Verification
- Deploy to device/emulator.
- Check timer behavior under app lifecycle events (backgrounding, screen lock).
- Verify timer display for all states (normal, warning, critical, expired).
