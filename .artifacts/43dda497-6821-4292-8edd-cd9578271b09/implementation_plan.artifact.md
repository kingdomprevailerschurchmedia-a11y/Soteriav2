# Epic 9: Competitive Gameplay, Leaderboards & Player Progression
# Story 9.1: Player Progression, Levels, XP & Competitive Rank Foundation

Establishing the foundational competitive identity system for Soteria.

## Proposed Changes

### Domain Models
#### [NEW] [player_progression.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/player_progression.dart)
Comprehensive progression model including Lifetime XP, Level, Rank, and Season info.
#### [NEW] [xp_transaction.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/xp_transaction.dart)
Traceable and idempotent XP changes.
#### [NEW] [rank_tier.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/rank_tier.dart)
Bronze, Silver, Gold, etc.
#### [NEW] [competitive_season.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/competitive_season.dart)
Season ID, dates, and status.

### Configuration
#### [NEW] [progression_config.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/config/progression_config.dart)
Configurable Level curve and Rank tiers.

### Repository & Logic
#### [NEW] [player_progression_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/repositories/player_progression_repository.dart)
Abstract repository.
#### [NEW] [firebase_player_progression_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/data/repositories/firebase_player_progression_repository.dart)
Authoritative Firestore implementation.
#### [NEW] [progression_service.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/services/progression_service.dart)
Logic for level calculation and XP processing.

### Providers
#### [NEW] [progression_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/providers/progression_providers.dart)
Riverpod providers for state management.

### UI Components
#### [NEW] [player_progression_card.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/player_progression_card.dart)
#### [NEW] [rank_badge.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/rank_badge.dart)
#### [NEW] [level_up_celebration.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/level_up_celebration.dart)

### Integration
- Profile screen integration.
- Dashboard integration.

## Verification Plan
### Automated Tests
- Unit tests for XP calculation, level-up logic, and rank tier boundaries.
- Mock data for all progression states.
- Golden tests for UI components.
### Manual Verification
- Verify progression updates after quiz completion.
- Verify level-up celebration trigger.
- Check responsive layouts on different screen sizes.
