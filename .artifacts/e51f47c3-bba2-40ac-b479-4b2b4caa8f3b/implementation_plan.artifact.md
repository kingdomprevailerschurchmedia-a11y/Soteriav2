# Robust Pro Mode Session Lifecycle & Stale Session Recovery

The Pro Mode session initialization currently lacks atomicity and robust failure recovery. If a session is reserved but fails to start or navigate, it leaves a "stale" active session in Firestore that blocks subsequent attempts for 20 minutes. This plan addresses these issues by implementing transactional initialization, aggressive stale-session detection, and authoritative cleanup.

## User Review Required

> [!IMPORTANT]
> This change modifies the entry fee reservation logic. If a network failure occurs after the fee is deducted but before the session is created, the system will now attempt an immediate auto-refund.

> [!WARNING]
> Stale session detection in the repository will be reduced from 20 minutes to 2 minutes for sessions that haven't transitioned to 'active' status.

## Proposed Changes

### Gameplay Engine Core

#### [MODIFY] [FirestoreProModeRepository](file:///C:/Joseph Project/Soteria/lib/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart)
- Update `reserveEntryFee` to distinguish between `initialized` and `active` sessions in the stale check.
- Reduce the stale timeout for `initialized` sessions to 2 minutes.
- Ensure `refundEntryFee` syncs with `wallets` and `user_game_profiles` collections to maintain consistency across the financial system.

#### [MODIFY] [CompetitiveSession](file:///C:/Joseph Project/Soteria/lib/features/gameplay_engine/models/competitive_session.dart)
- Add `lastHeartbeatAt` and `createdAt` fields for better lifecycle tracking.

---

### Dashboard & Lobby

#### [MODIFY] [ProLobbyNotifier](file:///C:/Joseph Project/Soteria/lib/features/dashboard/presentation/providers/pro_lobby_providers.dart)
- Update `startSession` to be a "transaction-like" workflow:
    1. Check for stale existing sessions and clean them up *before* starting.
    2. Wrap fee reservation and session creation in a robust try-catch.
    3. Perform immediate auto-refund if session creation fails after fee reservation.
- Add `isStarting` to `ProLobbyState` to drive UI feedback.

#### [MODIFY] [ProLobbyScreen](file:///C:/Joseph Project/Soteria/lib/features/dashboard/presentation/screens/pro_lobby_screen.dart)
- Disable the "INITIALIZE SESSION" button while `isStarting` is true.
- Show a dedicated "INITIALIZING SECURE SESSION..." overlay or loader.
- Handle `startSession` errors by displaying the specific reason to the user.

---

### Gameplay Lifecycle

#### [MODIFY] [GameEngine](file:///C:/Joseph Project/Soteria/lib/features/gameplay_engine/providers/game_engine_provider.dart)
- Ensure the heartbeat updates `lastHeartbeatAt` on the session document.
- Refine the scoring logic in `_endSession` to use `answerHistory` for correct/wrong counts instead of `score ~/ 100`.

## Verification Plan

### Automated Tests
- `gradle_build` to ensure compilation.
- Unit tests for `ProLobbyNotifier` to simulate failures at each step of `startSession` and verify refunds.

### Manual Verification
- Deploy to device/emulator.
- Test "stale session" scenario: Force close app during initialization, restart, and verify the lobby allows new entry after 2 minutes (or cleans up immediately).
- Verify coin balance remains consistent after a failed initialization.
