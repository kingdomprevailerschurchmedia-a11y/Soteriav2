# Pro Mode Foundation

This document describes the foundational architecture for Soteria Pro Mode.

## Architecture

Pro Mode is designed as a premium extension of the Practice Mode, utilizing the same core Question Platform and Quiz Engine while enforcing stricter rules and authoritative access control.

### Domain Models

#### ProModeAccess
Encapsulates the state of user access to Pro Mode.
- `available`: Access granted.
- `locked`: User does not meet level requirements.
- `insufficientTokens`: User does not have enough coins for the entry fee.
- `insufficientContent`: Not enough questions exist in the bank for the current configuration.

#### ProSessionConfig
Configuration for a Pro Mode session, including:
- `difficulty`: Stricter levels (Intermediate, Advanced, Expert, Adaptive).
- `entryFee`: Coin cost to start the session.
- `minLevelRequirement`: Minimum player level to unlock the mode.

#### CompetitiveSession
Represents an initialized Pro Mode session. Unlike standard practice sessions, it includes the pre-selected `questions` to ensure session integrity.

## Access Model

Access is validated through a multi-stage process:
1. **Client-side Pre-validation**: Checks level and coin balance against local profile state.
2. **Content Verification**: Checks Firestore for available question counts matching the configuration.
3. **Authoritative Reservation**: Uses a Firestore transaction to deduct coins and record a reservation before the session is created.

## Session Creation Flow

1. User configures session in `ProLobbyScreen`.
2. `ProLobbyNotifier` validates access and checks question availability.
3. `startSession()` is called:
   - `QuestionSelectionService` fetches and filters questions.
   - `ProModeRepository` reserves the entry fee (atomic transaction).
   - `CompetitiveSession` is created in Firestore.
   - User is navigated to gameplay (Story 10.9).

## Idempotency
`sessionId` (UUID) is generated at the start of the `startSession` process and used as the document ID for both the fee reservation and the session record, preventing duplicate charges or sessions from a single request.

## Security
- Entry fees are deducted via server-side transactions (simulated here in repository).
- Sessions are isolated by `uid`.
- Pro Mode availability is gated by Remote Config values (`minLevelRequirement`).

## Offline Behavior
Pro Mode requires an active internet connection to:
1. Verify competitive integrity.
2. Sync coin balances.
3. Fetch fresh questions.
An offline overlay is shown if connectivity is lost in the lobby.
