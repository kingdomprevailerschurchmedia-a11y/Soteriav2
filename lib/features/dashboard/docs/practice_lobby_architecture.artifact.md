# Practice Lobby Architecture

## Objective
Establish a high-fidelity entry point for Practice Mode that handles session configuration, player validation, and engine initialization.

## Components

### 1. State Management (Riverpod)
- **`PracticeLobbyProvider`**: Orchestrates the lobby state, combining category loading, user configuration, and validation errors.
- **`SessionConfigurationProvider`**: Manages the transient state of player choices (Difficulty, Category, etc.) before the session starts.

### 2. Validation & Estimation Services
- **`SessionValidator`**: A pure domain service that verifies eligibility (Level requirements, Premium status) independently of the UI.
- **`RewardEstimator`**: Calculates potential XP and Coin rewards based on dynamic multipliers from Remote Config.

### 3. Data Layer
- **`CategoryRepository`**: Fetches quiz topics from Firestore with offline caching support.
- **`PracticeRepository`**: Handles the creation of session metadata records in the `/practice_sessions` collection.

## Session Initialization Flow
1. **Selection**: Player chooses Category and Difficulty.
2. **Validation**: Lobby listens to changes and runs `SessionValidator` continuously.
3. **Initialization**: On "START", a unique `sessionId` is generated.
4. **Persistence**: Session metadata (uid, config, startTime) is saved to Firestore.
5. **Transition**: Navigation coordinator routes the player to the Question screen.

## Future Extension Points
- **Adaptive Mode**: Ready to integrate with the performance tracking engine.
- **Sponsored Events**: Branding can be overridden via Remote Config `lobby_theme` keys.
- **Pre-loading**: Questions are pre-fetched during the lobby phase to ensure zero-latency start.
