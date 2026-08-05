# Tournament Architecture

## Registration Flow
The registration process is managed by the `TournamentRegistrationNotifier` (an `AsyncNotifier`).

1. **Trigger**: User taps the action button in `RegistrationActionBox`.
2. **Action**: The `TournamentDetailsScreen` determines whether to `register`, `unregister`, or `navigate` to the lobby based on the current `TournamentStatus` and registration state.
3. **Execution**: `TournamentRegistrationNotifier` calls the `TournamentRepository` to update the backend.
4. **State Management**: Upon success, the notifier calls `ref.invalidate(isRegisteredForTournamentProvider(id))` to force a refresh of the registration status across the app.
5. **UI Feedback**: `RegistrationActionBox` listens to the notifier's `AsyncValue` to show loading states and prevent double-submissions.

## Countdown Strategy
Countdowns are implemented using a reactive stream to ensure accuracy and minimal resource usage.

- **Provider**: `tournamentCountdownProvider` is a `StreamProvider.family<Duration, DateTime>`.
- **Mechanism**: It uses `Stream.periodic` with a 1-second interval to calculate the difference between the `targetDate` and `DateTime.now()`.
- **Efficiency**: Since it is a `family` provider, multiple widgets watching the same tournament date will share the same stream subscription.
- **Accessibility**: The `TournamentCountdownWidget` uses `Semantics` to provide a clear readout of the remaining time for screen readers, updated as the timer ticks.
