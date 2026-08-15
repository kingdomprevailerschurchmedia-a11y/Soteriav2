# Epic 11: Story 11.1 — Progression Source-of-Truth & Security Foundation

This story stabilizes and unifies the progression architecture of Soteria, ensuring a single source of truth for XP/Levels, a unified formula, and a secure Firestore foundation compatible with the Firebase Spark plan.

## User Review Required

> [!IMPORTANT]
> **Level Re-calculation**: Unifying the level formula will cause existing users' levels to be re-calculated upon their next XP gain or profile refresh. Based on the audit, the `LevelConfig` formula (power curve) is more "game-like" than the `ProgressionConfig` formula (linear). Users may see a level jump (e.g., Level 10 → Level 23) because the new formula is more generous at lower levels.

> [!WARNING]
> **Firestore Security Rules**: I am introducing mandatory transaction logging for progression updates. Clients will NO LONGER be able to arbitrarily set `xp` or `level` in `player_progression` without creating a corresponding `xp_transactions` or `rank_transactions` document.

## Proposed Changes

### [Component] Progression Domain & Config

Unify the level formula and constants in `ProgressionConfig`.

#### [MODIFY] [ProgressionConfig.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/domain/config/progression_config.dart)
- Update `baseLevelXP`, `levelExponent`, and `linearFactor` to match `LevelConfig` defaults (100, 1.5, 50).
- Update `xpRequiredForLevel` to use the power curve formula: `baseXP * (level - 1)^exponent + linearFactor * (level - 1)`.

#### [MODIFY] [player_progression.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/domain/models/player_progression.dart)
- Add `lastXpTransactionId` and `lastRankTransactionId` fields to track the most recent applied changes.
- These fields will be used by Firestore Security Rules to verify that every update is backed by a transaction log.

#### [MODIFY] [progression_service.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/domain/services/progression_service.dart)
- Update `addXp` to correctly update the new transaction tracking fields.
- Ensure it uses the unified `ProgressionConfig` formula.

---

### [Component] Gameplay Engine Integration

Ensure the gameplay engine uses the same authoritative progression rules.

#### [MODIFY] [level_engine.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/gameplay_engine/progression/services/level_engine.dart)
- Update to use `ProgressionConfig` for level calculations instead of the standalone `LevelConfig`.

#### [DELETE] [level_config.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/gameplay_engine/progression/models/level_config.dart)
- Remove this redundant configuration file in favor of the centralized `ProgressionConfig`.

---

### [Component] Data & Persistence

Enforce the source of truth in repositories.

#### [MODIFY] [firebase_player_progression_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/data/repositories/firebase_player_progression_repository.dart)
- Update `applyXpTransaction` and `applyCompetitiveResult` to include the transaction/result IDs in the `player_progression` document update.
- This enables the `existsAfter` check in Firestore rules.

#### [MODIFY] [firestore_player_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/data/repositories/firestore_player_repository.dart)
- Ensure `updatePlayerProfile` continues to protect `xp` and `level` fields (already enforced by rules, but good to ensure the DTO doesn't try to overwrite them unnecessarily).

---

### [Component] Security Rules

#### [MODIFY] [firestore.rules](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/firestore.rules)
- **player_progression**:
    - Allow `read` for owners.
    - Allow `update` ONLY if `request.resource.data.lastXpTransactionId` corresponds to a new document in `xp_transactions` OR `lastRankTransactionId` corresponds to one in `rank_transactions`.
- **xp_transactions**:
    - Allow `create` by owner.
    - Validate `amount` is within a sane range (e.g., < 5000 XP) to prevent "Mega-XP" exploits.
- **rank_transactions**:
    - Allow `create` by owner.
    - Validate `changeAmount` is within a sane range (e.g., < 100 RP).

## Source-of-Truth Matrix

| Concept | Source of Truth | Collection | Owner |
| :--- | :--- | :--- | :--- |
| **XP (Current Level)** | Authoritative | `player_progression` | `ProgressionService` |
| **XP (Lifetime)** | Authoritative | `player_progression` | `ProgressionService` |
| **Level** | Authoritative | `player_progression` | `ProgressionService` |
| **Rank / RP** | Authoritative | `player_progression` | `CompetitiveRankingEngine` |
| **XP / Level (Legacy)** | Derived/Cached | `users` | N/A (Read-only for client) |

## Verification Plan

### Automated Tests
- `flutter test test/features/player/progression_service_test.dart`: Verify unified formula.
- `flutter test test/features/gameplay_engine/progression/progression_engine_test.dart`: Verify gameplay uses new formula.
- `flutter test test/features/player/ranking_security_test.dart`: Verify transaction-based security (mocking Firestore rules behavior).

### Manual Verification
- Launch the app and complete a Practice session. Verify XP is awarded and level updates.
- Complete a Pro session. Verify XP and Rank points are awarded.
- Check Firestore to ensure `player_progression` and `xp_transactions` documents are created correctly with matching IDs.
