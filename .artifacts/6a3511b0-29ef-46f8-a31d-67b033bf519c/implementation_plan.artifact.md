# Implementation Plan - Story 8.5: Countdown Timer & Time Management System

Implement a production-grade countdown timer engine integrated into the Quiz Engine, ensuring accurate, testable, and responsive question timing.

## User Review Required

> [!IMPORTANT]
> The timer will be owned by the `QuizController` and will use an absolute deadline-based approach to avoid drift. It will automatically handle timeouts by submitting a "timed out" answer.

- **Clock Abstraction**: I will create a `Clock` interface to allow for deterministic testing using a `FakeClock`.
- **Thresholds**: Warning and Critical thresholds will be configurable.
- **App Lifecycle**: The timer will react to app foreground/background changes (currently set to continue/sync on resume).

## Proposed Changes

### Domain Layer

#### [MODIFY] [quiz_enums.dart](file:///C:/Joseph%20Project/lib/features/quiz/domain/models/quiz_enums.dart)
- Add `TimerStatus` enum: `idle`, `running`, `paused`, `expired`, `warning`, `critical`.

#### [MODIFY] [timer_state.dart](file:///C:/Joseph%20Project/lib/features/quiz/domain/models/timer_state.dart)
- Add `TimerStatus status`.
- Add `DateTime? deadline`.

### Infrastructure Layer

#### [NEW] [clock.dart](file:///C:/Joseph%20Project/lib/core/utils/clock.dart)
- Define `IClock` interface with `now()`.
- Implement `SystemClock`.
- Provide `clockProvider` via Riverpod.

### Presentation Layer (Controllers)

#### [MODIFY] [quiz_controller.dart](file:///C:/Joseph%20Project/lib/features/quiz/presentation/controllers/quiz_controller.dart)
- Add `Timer? _ticker`.
- Implement `_startTimer(Duration duration)`, `_stopTimer()`, `_onTick()`.
- Integrate into `startQuiz`, `selectAnswer`, and `_nextQuestion`.
- Implement `_handleTimeout()` to record a timed-out answer and transition.
- Add lifecycle listener support.

### Presentation Layer (Widgets)

#### [NEW] [quiz_timer.dart](file:///C:/Joseph%20Project/lib/features/quiz/presentation/widgets/quiz_timer.dart)
- Extract from `QuizStatsBar`.
- Add animations (pulse for critical state).
- Use `TimerStatus` for visual states.
- Support Accessibility (Semantics for remaining time).

#### [MODIFY] [quiz_stats_bar.dart](file:///C:/Joseph%20Project/lib/features/quiz/presentation/widgets/quiz_stats_bar.dart)
- Replace inline timer logic with the new `QuizTimer` component.

### Preview & Testing

#### [MODIFY] [gameplay_previews.dart](file:///C:/Joseph%20Project/lib/features/quiz/preview/gameplay_previews.dart)
- Update previews to use various `TimerStatus` and time values.

#### [NEW] [timer_engine_test.dart](file:///C:/Joseph%20Project/test/features/quiz/timer_engine_test.dart)
- Unit tests for timer lifecycle and thresholds using `FakeClock`.

## Verification Plan

### Automated Tests
- `flutter test test/features/quiz/timer_engine_test.dart`
- `flutter analyze`

### Manual Verification
- **Cold Start**: Start quiz, verify timer begins.
- **Thresholds**: Observe transition to Warning (e.g., 10s) and Critical (e.g., 5s) states.
- **Expiration**: Let timer reach 00:00, verify question locks and moves to next.
- **Race Condition**: Try to answer at the last second.
- **Accessibility**: Verify screen reader announces time increments/thresholds.
