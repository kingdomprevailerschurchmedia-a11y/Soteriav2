# Competitive Matchmaking Architecture

Soteria uses a server-authoritative matchmaking system to pair players for 1v1 Versus matches.

## Flow

1. **Lobby**: Player selects Versus mode and configures the match (Category, Difficulty).
2. **Queueing**: Player enters the `matchmaking_pool` collection in Firestore.
3. **Searching**: The client observes its own pool entry. 
4. **Match Found**: A backend process (or another client in this demo implementation) identifies a pair and updates both sessions with an `opponentId` and status `matchFound`.
5. **Confirmation**: Both players must confirm readiness.
6. **Match Creation**: Once both are ready, a `VersusMatch` is created, and players navigate to the gameplay engine.

## State Machine

- `idle`: Not in queue.
- `queuing`: Requesting queue entry.
- `searching`: Waiting for an opponent.
- `matchFound`: Opponent identified, waiting for confirmation.
- `confirming`: Player has confirmed, waiting for opponent.
- `matched`: Both players ready, match created.
- `cancelled`: Player left the queue.
- `expired`: Queue time limit reached.
- `failed`: An error occurred.

## Security

- **Ownership**: Users can only create/update their own matchmaking sessions.
- **Authority**: Match creation and opponent selection are intended to be server-side operations.
- **Idempotency**: Existing active sessions are checked before entering a new queue.

## Components

- `VersusLobbyScreen`: Configuration and entry point.
- `MatchmakingScreen`: Real-time queue status and timer.
- `MatchFoundScreen`: Opponent preview and readiness confirmation.
