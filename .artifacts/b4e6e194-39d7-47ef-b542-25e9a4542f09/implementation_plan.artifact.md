# Implementation Plan - Story 11.6: Milestones & Goals

Implement a production-ready Milestones & Goals system by hardening existing infrastructure and ensuring deterministic, idempotent, and secure player progression.

## User Review Required

> [!IMPORTANT]
> **Firestore Security**: The current Firestore rules allow clients to modify their own milestone and goal status/progress. For a production-ready system on the Firebase Spark plan (no Cloud Functions), we will harden the rules to prevent arbitrary modification of `status` and `claimedAt` without valid context, and ensure rewards are only granted once per completion.

> [!WARNING]
> **Reward Integration**: All XP rewards will be routed through the Story 11.4 `XPTransaction` architecture. We will NOT directly mutate `currentXp` or `currentLevel` in the Goal/Milestone services.

## Proposed Changes

### Domain Layer (Models & Services)

#### [MODIFY] [milestone.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/milestone.dart)
*   Ensure `MilestoneDefinition` and `PlayerMilestone` are robust.
*   Add `GoalDefinition` and `PlayerGoal` (refactoring `CompetitiveGoal`).

#### [NEW] [goal_definition.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/goal_definition.dart)
*   Define `GoalDefinition` with `goalId`, `title`, `description`, `category`, `requirementType`, `targetValue`, `timeWindow`, and `rewardMetadata`.

#### [NEW] [player_goal.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/player_goal.dart)
*   Define `PlayerGoal` with `userId`, `goalId`, `progress`, `status`, `startedAt`, `expiresAt`, `completedAt`, and `claimedAt`.

#### [MODIFY] [milestone_evaluation_service.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/services/milestone_evaluation_service.dart)
*   Harden progress calculation to use only authoritative sources (`PlayerProgression`, `CompetitiveStatistics`, `CompetitiveHistory`).
*   Ensure idempotency (skip already completed/claimed milestones).

#### [MODIFY] [competitive_goal_evaluation_service.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/services/competitive_goal_evaluation_service.dart)
*   Update to use `GoalDefinition` and `PlayerGoal`.
*   Support daily, weekly, and one-time windows.
*   Ensure deterministic evaluation based on `QuizResult` and `CompetitiveStatistics`.

#### [NEW] [progression_reward_service.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/services/progression_reward_service.dart)
*   Handle reward processing for both Milestones and Goals.
*   Ensure idempotency by checking `claimedAt` and creating a unique `XPTransaction`.

---

### Data Layer (Repositories)

#### [MODIFY] [firebase_milestone_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/data/repositories/firebase_milestone_repository.dart)
*   Support fetching definitions from a central `milestone_definitions` collection (or keep static if mandated, but will prepare for Firestore).
*   Ensure `PlayerMilestone` updates are consistent.

#### [MODIFY] [firebase_goal_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/data/repositories/firebase_goal_repository.dart)
*   Update to use `GoalDefinition` and `PlayerGoal`.
*   Implement `refreshGoals` using `GoalDefinition` registry.

---

### UI Layer

#### [MODIFY] [Goal & Milestone Widgets]
*   Update existing cards and screens to use the new separated models.
*   Ensure accessibility semantics (Instruction 18).

---

### Configuration & Registry

#### [NEW] [milestone_registry.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/config/milestone_registry.dart)
*   Central registry of authoritative `MilestoneDefinition` objects.

#### [NEW] [goal_registry.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/config/goal_registry.dart)
*   Central registry of authoritative `GoalDefinition` objects.

## Verification Plan

### Automated Tests
*   `milestone_evaluation_test.dart`: Verify deterministic progress and completion for all requirement types.
*   `goal_evaluation_test.dart`: Verify time-window handling and progress calculation.
*   `progression_reward_test.dart`: Verify idempotency of rewards and integration with `XPTransaction`.
*   `security_audit_test.dart`: (Mock) Verify that clients cannot forge completions or rewards.

### Manual Verification
*   Use **Developer Preview** to simulate:
    *   Completing a daily goal.
    *   Achieving a milestone.
    *   Claiming rewards twice (should fail).
    *   Offline progress synchronization.
    *   Simultaneous evaluation of multiple goals.
