# Quiz Countdown Timer & Time Management System Implementation Plan

This plan outlines the implementation of a production-grade, deterministic, and absolute-deadline-based countdown timer system for the Soteria Quiz Engine, extending the existing architecture without creating redundant controllers or state machines.

## User Review Required

- **Clock Abstraction**: I am introducing a `Clock` abstraction to allow for deterministic testing (fake clocks) and to replace the current dependency on `DateTime.now()` for critical timing.
- **Background Policy**: The system will pause the timer when the app is backgrounded and resume when foregrounded, to ensure the timer remains accurate and doesn't "run away" while the user cannot see it, which is the standard expected behavior for this type of quiz.
- **Timer Engine**: The `QuizController` will be refactored to treat the `TimerState` as an immutable snapshot. The ticker will be moved into a more robust `QuizTimerEngine` component owned by the controller.

## Proposed Changes

### Component: Quiz Engine (Domain & Presentation)

#### [MODIFY] [QuizController.dart](file:///C:/Users/kpc-m/AndroidStudioProjects/PROJECT/Soteria/lib/features/quiz/presentation/controllers/quiz_controller.dart)
- Replace `Timer.periodic` with an `AbsoluteDeadline` calculation mechanism.
- Implement `QuizTimerEngine` to manage the countdown, warning/critical state transitions, and timeouts based on `Clock`.
- Ensure race-condition protection (e.g., answer submitted at the exact deadline).

#### [NEW] [TimerEngine.dart](file:///C:/Users/kpc-m/AndroidStudioProjects/PROJECT/Soteria/lib/features/quiz/domain/services/timer_engine.dart)
- Manages the logic for calculating time remaining from an absolute deadline.
- Emits states: Running, Warning, Critical, Expired, Paused, Idle.
- Handles race condition logic internally.

#### [NEW] [Clock.dart](file:///C:/Users/kpc-m/AndroidStudioProjects/PROJECT/Soteria/lib/core/utils/clock.dart)
- Define a `Clock` interface with `DateTime now()`.
- Provide a `SystemClock` implementation for production.
- Provide a `FakeClock` implementation for unit/widget tests.

#### [MODIFY] [QuizTimer.dart](file:///C:/Users/kpc-m/AndroidStudioProjects/PROJECT/Soteria/lib/features/quiz/presentation/widgets/quiz_timer.dart)
- Update to react only to `TimerState` changes.
- Ensure visual states (Warning/Critical) are derived from the engine's state, not hardcoded threshold logic.
- Ensure no layout shifts or flickering.

## Verification Plan

### Automated Tests
- Create `TimerEngineTest.dart`:
  - Verify timer start/stop/reset logic.
  - Test warning/critical thresholds.
  - Validate absolute deadline calculation (ensure no drift).
  - Test race condition (answer at deadline).
  - Verify `FakeClock` behavior.
- Add `QuizControllerTest.dart` coverage for time-based states.

### Manual Verification
- Deploy to test device.
- Verify timer countdown accuracy with physical stopwatch.
- Test background/foreground behavior.
- Test offline timer functionality.
- Check accessibility semantics.
