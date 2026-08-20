# Fix: Welcome Gift Appearing Repeatedly

The "Welcome Gift" (milestone: `welcome_bonus`) is appearing repeatedly in the Rewards tab's "Earn" section because of a cycle involving Firestore date serialization and the milestone evaluation service.

## Problem Analysis

1.  **Date Serialization Mismatch**: `FirestoreRewardsRepository.claimReward` updates the milestone status to `claimed` and sets `claimedAt` using `FieldValue.serverTimestamp()`. This creates a `Timestamp` object in Firestore.
2.  **Parsing Failure**: The `PlayerMilestone` domain model (generated via Freezed) expects a `String` (ISO 8601) for `DateTime` fields by default. When `FirebaseMilestoneRepository.watchPlayerMilestones` tries to parse the document containing a `Timestamp`, it fails.
3.  **Evaluator Overwrite**: The `milestoneEvaluationProvider` orchestrator relies on the stream of milestones. If a document fails to parse, it might be skipped or cause an error. When the orchestrator re-runs (triggered by coin/profile updates), it sees the milestone as "missing" or "locked" and re-evaluates it.
4.  **Welcome Bonus Logic**: The `MilestoneEvaluationService` evaluates `MilestoneType.welcome` as always "completed" (`1.0`). If it doesn't see a `claimed` or `completed` status in the current states (due to the parsing failure), it marks it as `completed` and saves it back to Firestore, overwriting the `claimed` status.
5.  **UI Feedback**: The user sees the milestone as "claimable" again because it's back to `completed` status in Firestore.

## Proposed Changes

### Core Utils
#### [NEW] [json_converters.dart](file:///C:/Users/USER/AndroidStudioProjects/Soteria/lib/core/utils/json_converters.dart)
- Create a shared `TimestampConverter` that can handle both `String` (ISO 8601) and Firestore `Timestamp` objects.

### Player Feature (Domain)
#### [MODIFY] [milestone.dart](file:///C:/Users/USER/AndroidStudioProjects/Soteria/lib/features/player/domain/models/milestone.dart)
- Apply `@TimestampConverter()` to `unlockedAt` and `claimedAt` in `PlayerMilestone`.

#### [MODIFY] [reward_grant.dart](file:///C:/Users/USER/AndroidStudioProjects/Soteria/lib/features/player/domain/models/reward_grant.dart)
- Apply `@TimestampConverter()` to date fields to prevent similar issues with reward grants.

### Rewards Feature (Data)
#### [MODIFY] [firestore_rewards_repository.dart](file:///C:/Users/USER/AndroidStudioProjects/Soteria/lib/features/rewards/data/repositories/firestore_rewards_repository.dart)
- Update `claimReward` to use ISO strings for `claimedAt` in milestone documents to be consistent with other milestone updates, although the converter will make it resilient to both.

### Auth Feature (Data)
#### [MODIFY] [firebase_registration_repository.dart](file:///C:/Users/USER/AndroidStudioProjects/Soteria/lib/features/auth/repositories/firebase_registration_repository.dart)
- Update registration to use ISO strings or ensure compatibility with the new converter.

## Verification Plan

### Automated Tests
- Run `test/features/player/milestone_evaluation_test.dart` to ensure no regression in evaluation logic.
- Add a unit test for `TimestampConverter` to verify it handles `Timestamp`, `String`, and `null` correctly.

### Manual Verification
1.  Register a new user and verify "Welcome Gift" appears once.
2.  Claim the "Welcome Gift" and verify it changes to "Claimed" (checkmarked).
3.  Navigate away and back to the Rewards tab to ensure it stays "Claimed".
4.  Perform other activities (earn coins, win games) and verify the "Welcome Gift" does not reappear.
