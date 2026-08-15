# Pro Mode Gameplay

This document describes the gameplay architecture and mechanics for Soteria Pro Mode.

## Loop
The Pro Mode gameplay loop follows a high-intensity, timed sequence:
1. **Lobby**: User selects category and difficulty, pays entry fee.
2. **Initialization**: A `CompetitiveSession` is created with a fixed, locked set of questions.
3. **Gameplay**: 
   - Questions are presented one by one.
   - Authoritative timer (15 seconds per question) enforces speed.
   - Lives are limited (3 strikes and the session fails).
4. **Answer Submission**: Answers are submitted to the authoritative `GameEngine`.
5. **Feedback**: Immediate correctness feedback is provided.
6. **Progression**: Engine moves to the next question automatically after a short delay.
7. **Completion**: Upon finishing all questions or losing all lives, the session state is finalized and handed off to the Results story.

## Session Integrity
- **Locked Content**: Questions are pre-selected in the lobby and cannot be changed or re-queried during the session.
- **Fixed Order**: Questions must be answered in the order they were initialized.
- **No Cheating**: Correctness and scoring are managed by the domain layer (`GameEngine`), not the UI.

## UI/UX
- **Premium Design**: Uses Gold and Primary design tokens to distinguish from Practice mode.
- **Clear Progress**: "Question X of Y" and a persistent progress bar.
- **Visible Stakes**: Lives are shown as hearts in the header.
- **Exit Handling**: Abandoning a match results in forfeiture of the entry fee.

## Implementation Details
- **Screen**: `ProGameplayScreen`
- **Engine**: Generic `GameEngine` family provider using `GameMode.pro`.
- **Heartbeat**: `ProGameplayNotifier` provides periodic session checkpoints to Firestore.

## Result Handoff
Story 10.9 produces a completed `GameState` which is passed to the Results screen (`Story 10.10`).
