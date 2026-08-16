# EPIC 11 Integration & Certification Plan

## Goal Description
Perform final production integration, audit, and certification of EPIC 11 (Progression & Social). The goal is to ensure all systems work together as a coherent architecture without duplicate sources of truth, circular dependencies, or security bypasses.

## User Review Required
> [!IMPORTANT]
> **Source of Truth Redundancy**: `PlayerProfile` (users collection) contains redundant `xp` and `level` fields that are currently not synchronized with the authoritative `player_progression` collection. I propose treating `player_progression` as the EXCLUSIVE source of truth for these fields and potentially deprecating or strictly syncing the profile fields.

> [!WARNING]
> **Firestore Security Vulnerabilities**: Current rules allow clients to self-grant XP (up to 5000) and self-unlock achievements. This is a trade-off for Firebase Spark compatibility (no Cloud Functions). If stricter security is required, we must implement server-side validation.

> [!CAUTION]
> **Test Failures**: Multiple integration tests are currently failing due to a signature change in `FirebasePlayerProgressionRepository`. These must be fixed to complete certification.

## Proposed Changes

### 1. Fix Integration Test Failures
Update existing tests to match the new `FirebasePlayerProgressionRepository` constructor (which now requires `LeaderboardRepository` and `PlayerRepository`).

#### [MODIFY] [progression_integration_test.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/test/features/player/progression_integration_test.dart)
#### [MODIFY] [ranking_security_test.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/test/features/player/ranking_security_test.dart)
#### [MODIFY] [xp_transaction_integrity_test.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/test/features/player/xp_transaction_integrity_test.dart)

### 2. Address Source of Truth Conflicts
Hardening the `PlayerProfile` and `PlayerProgression` relationship.

#### [MODIFY] [achievement_service.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/services/achievement_service.dart)
Ensure all evaluations use `PlayerProgression` for XP and Level.

### 3. Final Regression Testing
Run the complete suite for Epic 11, Epic 9, and Timers.

## Verification Plan

### Automated Tests
- `flutter analyze`
- `flutter test test/features/player/`
- `flutter test test/features/gameplay_engine/progression/`
- `flutter test test/features/gameplay_engine/integrity/timer_anomaly_test.dart`
- `flutter test test/features/gameplay_engine/timer_integrity_test.dart`

### Manual Verification
- Verify Developer Preview scenarios for all Epic 11 features.
- Perform a final accessibility and design system check.
