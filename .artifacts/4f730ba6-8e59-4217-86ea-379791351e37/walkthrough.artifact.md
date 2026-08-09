# Walkthrough - Quiz Countdown Timer & Time Management System

Implemented a production-grade, deterministic, absolute-deadline-based countdown timer and time management system integrated directly into the Soteria Quiz Engine.

## Changes Made

### Core & Domain Architecture
- **[NEW] `Clock` abstraction & `FakeClock` / `SystemClock`**: Introduced absolute-time tracking to completely avoid accumulated drift and support instant, deterministic unit testing.
- **[NEW] `TimerEngine`**: Encapsulates the timer logic, state transitions (Normal, Warning, Critical, Expired, Paused), and handles absolute deadline difference calculations.
- **[EXTENDED] `QuizController` & `QuizState`**: Integrated the timer engine and added robust protections against double submission and simultaneous answer-at-deadline race conditions.
- **[UPDATED] `QuizTimer` UI**: Refactored to observe timer state cleanly without causing redundant full-screen rebuilds.

### Tests Added
- **[NEW] `timer_engine_test.dart`**: Verified timer creation, warning thresholds, critical thresholds, expiration, pause/resume offset preservation, and fake clock determinism.

## Verification Results

- Unit tests for the timer engine core mechanics successfully validate absolute deadline mathematics and state transitions.
- Fully compatible with future server-authoritative time synchronization and offline operation.
