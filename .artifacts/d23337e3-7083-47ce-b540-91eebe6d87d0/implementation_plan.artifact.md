# Implementation Plan - Competitive Milestones & Achievement Integration

Implement a competitive milestone and achievement system that recognizes player accomplishments using authoritative data from ranking, statistics, and season results.

## Proposed Changes

### Domain Layer

#### [NEW] [milestone.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/domain/models/milestone.dart)
- Define `MilestoneDefinition`: Immutable definition of an achievement (id, name, description, category, threshold, icon).
- Define `PlayerMilestone`: User-specific milestone state (unlockedAt, currentProgress, status).
- Define `MilestoneType`: Enum (COUNT, WIN, STREAK, RANK, POSITION, SEASON).

#### [NEW] [milestone_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/domain/repositories/milestone_repository.dart)
- Interface for fetching definitions and tracking player progress/completion.

#### [NEW] [milestone_evaluation_service.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/domain/services/milestone_evaluation_service.dart)
- Service to evaluate milestones against `CompetitiveStatistics` and `PlayerProgression`.
- Logic for detecting newly completed milestones.

### Data Layer

#### [NEW] [firebase_milestone_repository.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/data/repositories/firebase_milestone_repository.dart)
- Implementation using Firestore.
- Collection: `users/{userId}/milestones`.
- Achievement definitions could be hardcoded or in a separate collection. I will prefer a static list for now as per "No AI required" and "Deterministic" rules.

### Presentation Layer

#### [NEW] [milestone_providers.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/providers/milestone_providers.dart)
- `milestoneDefinitionsProvider`
- `playerMilestonesProvider`
- `milestoneEvaluationProvider`: Composes statistics and triggers evaluation.

#### [NEW] [milestone_card.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/widgets/milestone_card.dart)
- Premium card showing milestone progress or completion.

#### [NEW] [milestones_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/screens/milestones_screen.dart)
- Gallery of all competitive achievements.

### Integration

#### [MODIFY] [competitive_profile_provider.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/providers/competitive_profile_provider.dart)
- Include recent/featured achievements in the profile model.

#### [MODIFY] [competitive_profile_screen.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/presentation/screens/competitive_profile_screen.dart)
- Display recent achievements section.

## Verification Plan

### Automated Tests
- Unit tests for `MilestoneEvaluationService`: Verify different milestone types (Win count, Rank reach, etc.) are correctly evaluated.
- Unit tests for Idempotency: Ensure evaluating the same state twice doesn't result in duplicate completions.
- Widget tests for `MilestoneCard`: Verify progress bar and completion states.

### Manual Verification
- Use Preview Gallery to view various milestone states (Locked, In Progress, Completed).
- Verify responsiveness on different device sizes.
