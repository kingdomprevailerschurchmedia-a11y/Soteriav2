# Implementation Plan - Competitive Matchmaking & Opponent Discovery

Allow players to enter a competitive queue and be matched with an opponent for 1v1 Versus matches using a server-authoritative matchmaking system.

## User Review Required

> [!IMPORTANT]
> The matchmaking logic will use Firestore to coordinate between players. While a dedicated backend (Cloud Functions) would be ideal for a production game, we will implement a robust Firestore-based approach using transactions to ensure fairness and prevent race conditions.

- Players will enter a `matchmaking_pool` collection.
- A "Match Found" state will be triggered when two compatible sessions are paired.
- Both players must confirm (READY) before the `VersusMatch` is created.

## Proposed Changes

### Matchmaking Domain & Models

#### [NEW] [matchmaking_session.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/matchmaking/domain/models/matchmaking_session.dart)
- `MatchmakingSession` model with `sessionId`, `userId`, `status`, `configuration`, `rankSnapshot`, etc.
- `MatchmakingStatus` enum: `idle`, `queuing`, `searching`, `matchFound`, `confirming`, `matched`, `cancelled`, `expired`, `failed`.

#### [NEW] [matchmaking_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/matchmaking/domain/repositories/matchmaking_repository.dart)
- Interface for matchmaking operations: `enterQueue`, `cancelQueue`, `confirmMatch`, `observeSession`.

---

### Data Layer

#### [NEW] [firebase_matchmaking_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/matchmaking/data/repositories/firebase_matchmaking_repository.dart)
- Implementation using Firestore.
- Handles atomic entry into the pool.
- Observes the session document for status changes (e.g., when an opponent is assigned).

---

### Presentation Layer (Riverpod & Screens)

#### [NEW] [matchmaking_providers.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/matchmaking/presentation/providers/matchmaking_providers.dart)
- `matchmakingProvider`: Manages the current matchmaking state and timer.
- `matchmakingSessionProvider`: Streams the active session from the repository.

#### [NEW] [versus_lobby_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/matchmaking/presentation/screens/versus_lobby_screen.dart)
- Entry point for Versus mode.
- Allows configuration of the match (Category, Difficulty - though ranked usually has fixed rules).
- Reuses `CategorySelector` and `DifficultySelector`.

#### [NEW] [matchmaking_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/matchmaking/presentation/screens/matchmaking_screen.dart)
- Displays "Searching..." state, elapsed time, and player rank.
- Allows cancellation.

#### [NEW] [match_found_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/matchmaking/presentation/screens/match_found_screen.dart)
- Reveals the opponent.
- Comparison view (You vs. Opponent).
- "READY" confirmation button.

---

### Integration & Navigation

#### [MODIFY] [soteria_routes.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/core/navigation/soteria_routes.dart)
- Add `/app/versus/lobby`, `/app/matchmaking`, `/app/match-found`.

#### [MODIFY] [app_router.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/core/navigation/app_router.dart)
- Register new routes.
- Replace "Coming Soon" for Versus with the new `VersusLobbyScreen`.

#### [MODIFY] [firestore.rules](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/firebase/firestore.rules)
- Add security rules for the `matchmaking_pool` collection.

## Verification Plan

### Automated Tests
- **Domain Tests**: Test `MatchmakingStatus` transitions.
- **Repository Tests**: Mock Firestore to verify `enterQueue` and `confirmMatch` logic.
- **Provider Tests**: Verify `matchmakingProvider` emits correct states (Searching -> MatchFound -> Matched).

### Manual Verification
- Deploy to device/emulator.
- Enter Versus Lobby -> Configure -> Search.
- Verify searching animation and timer.
- Use Previews to verify "Match Found" UI with different ranks/opponents.
- Test cancellation flow.
