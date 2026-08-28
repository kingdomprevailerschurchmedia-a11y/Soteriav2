# Question Freshness Filter Walkthrough

I have implemented a **Freshness Filter** to ensure that competitive matches (Pro Mode, Versus, and Tournaments) always provide new and unique challenges to players.

## Changes Made

### 1. Persistent Freshness Tracking
- **Repository Update:** Added `getRecentlyAnsweredIds` to the `QuestionAnalyticsRepository`.
- **Firestore Integration:** The app now queries the `question_analytics_events` collection to retrieve every question ID a user has answered in the last **14 days**.

### 2. Pro Mode Integration
- **Session Start Logic:** Updated the `ProLobbyNotifier` to fetch the "Recently Answered" list *before* building a match.
- **Exclusion Mapping:** These IDs are automatically passed to the Question Selection Engine, which removes them from the available pool for that match.

### 3. Adaptive Pool Fetching
- **Smart Scaling:** Updated the `QuestionSelectionService` to dynamically increase its fetch limit from Firestore. If a user has answered many questions recently, the service will "over-fetch" a larger raw pool (e.g., `questionCount + excludedCount`) to guarantee that enough unique questions remain after filtering.

### 4. Safety and Reliability
- **Timeout Protection:** The history fetch is gated by a 5-second timeout. If the network is slow, it defaults to an empty list rather than blocking the game from starting.
- **Fallback Integrity:** If a user has answered *every* possible question in a category, the system's existing "Smart Fallback" logic ensures the game still starts by pulling from the general pool, preventing a "deadlock" state.

## Verification Results
- **Content Freshness:** Confirmed that questions from a recently completed session are successfully excluded from the next session in Pro Mode.
- **Fetch Performance:** Verified that the selection engine correctly scales its Firestore limits based on the user's history size.
- **Robustness:** Simulated Firestore query failures and confirmed that the game still starts gracefully.
