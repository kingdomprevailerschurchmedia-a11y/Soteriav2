# Gameplay Engine Specification - Soteria

## Overview
The Gameplay Engine is a reusable, state-driven orchestrator designed to power multiple game modes (Practice, Pro, Versus, Tournament). It decouples question rendering from business logic, timing, and progression.

## Question Lifecycle
1. **Ready**: Questions are loaded and the session is initialized.
2. **Playing**: Timer starts, lifelines are available, and the user can select an answer.
3. **Answering**: Selection is locked, haptic feedback is triggered.
4. **Answered**: Correct/Incorrect revealed, XP/Coins calculated, explanation shown.
5. **Advancing**: Transition to next question or session results.

## Session Lifecycle
- **Initialization**: `GameEngine.startSession` initializes state, integrity monitoring, and progression.
- **Persistence**: Checkpoints are saved locally via `LocalGameplayRepository` and metadata is synced to Firestore.
- **Resumption**: `GameplaySessionController` can hydrate `GameEngine` from local storage to resume an active session.

## Lifeline Engine
- **Fifty-Fifty**: Deterministically removes two incorrect answers based on `questionId`.
- **Ask the Audience**: Simulates audience votes with a probability curve influenced by `QuestionDifficulty`.
- **Pause Timer**: Temporarily halts the `TimerEngine`.
- **Architecture**: Pluggable `LifelineEngine` interface allows for future premium lifelines (e.g., Skip, Second Chance).

## Anti-Cheat Strategy
- **Wall-clock Drift Detection**: `TimerEngine` monitors the difference between ticks and system time.
- **Response Time Validation**: Submissions under 500ms trigger an integrity signal.
- **Server-side Validation**: Final results are recorded in Firestore for verification against expected session progress.

## Accessibility
- **Screen Readers**: All interactive elements (Answers, Timer, Lifelines) include semantic labels and roles.
- **Large Text**: `flutter_screenutil` and flexible layouts ensure readability across device sizes.
- **Haptics**: Clear haptic cues for selection, success, and failure.
