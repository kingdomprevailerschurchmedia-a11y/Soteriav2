# Post-Game Experience Architecture - Soteria

## Overview
The Post-Game Experience manages the transition from active gameplay to results, rewards, and data synchronization. It is designed to be atomic, offline-resilient, and visually premium.

## 1. Results Generation Flow
1. **Completion**: `GameEngine` reaches `GameLifecycle.completed`.
2. **Analysis**: `ResultsNotifier` collects `answerHistory` from the final `GameState`.
3. **Calculation**:
    - Accuracy, avg response time, and streaks are derived.
    - `RewardSummary` is calculated based on performance metrics (base XP, perfect score bonuses, etc.).
4. **Final Result**: A `GameResult` object is created, encapsulating all session metadata.

## 2. Synchronization Strategy
### Atomic Transactions
We use Firestore Transactions in `syncProgress` to ensure that XP and Coins are incremented accurately. This prevents race conditions and ensures that total player stats always reflect completed sessions correctly.

### Offline Queue
- If synchronization fails (e.g., no network), the `GameResult` is added to a local **Sync Queue** in `SharedPreferences`.
- The `SyncService` listens for connectivity changes and automatically retries syncing any pending sessions once the device is back online.

### Idempotency
Each session is stored in Firestore using its unique `sessionId` as the document ID. This ensures that even if a session is synced multiple times (e.g., during a retry), it only counts once towards the user's history and prevents duplicate rewards.

## 3. UI & Animation
- **Results Screen**: Uses `SoteriaPageWrapper` and staggered animations (250-350ms) to reveal the hero section, rewards, and analytics.
- **Level Progression**: The `LevelProgressionCard` implements a tick-based animation to count up gained XP and visually update the progress bar, supporting multiple level-ups in a single session.
- **Answer Review**: Enables players to see their chosen answer vs. the correct answer, complete with explanations and references for learning.

## 4. Anti-Cheat Measures
- **Validation**: Reward calculations are verified server-side (in a real production environment, this would be a Cloud Function).
- **Time Check**: `avgResponseTime` and `fastestAnswerTime` are tracked. Extremely low values are flagged for integrity review.
- **Lifecycle Locking**: Once a session is moved to `completed`, it cannot be resumed or edited.
