# Implementation Plan - User Interests → Question Selection & Personalization

Connect user interests from onboarding with the Question Platform to enable personalized question selection.

## User Review Required

> [!IMPORTANT]
> The interest labels in onboarding ('Science', 'Technology', etc.) will be normalized to lowercase slugs ('science', 'technology', etc.) to match the Category IDs in the Question Bank.

## Proposed Changes

### [Component] Question Content - Selection Domain

#### [NEW] [selection_models.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/question_content/domain/selection/selection_models.dart)
- `QuestionSelectionRequest`: Domain model for requesting questions.
    - `categoryIds` (List<String>)
    - `difficulty` (Difficulty?)
    - `count` (int)
    - `excludedIds` (Set<String>)
    - `mode` (GameMode?)
- `QuestionSelectionResult`: Domain model for selection output.
    - `questions` (List<Question>)
    - `status` (SelectionStatus: success, insufficientContent)

#### [MODIFY] [selection_strategy.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/question_content/domain/selection/selection_strategy.dart)
- Add `BalancedCategoryStrategy`: A strategy that balances questions across multiple requested categories.

### [Component] Question Content - Selection Logic

#### [NEW] [question_selection_service.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/question_content/domain/selection/question_selection_service.dart)
- `QuestionSelectionService`: Orchestrates fetching and filtering.
    - Resolves user interests to Category IDs.
    - Applies balancing and fallbacks.
    - Respects exclusions and difficulty.

### [Component] Personalization - Bridge

#### [NEW] [personalization_bridge.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/personalization/utils/personalization_bridge.dart)
- Utility to map onboarding labels to Category slugs.

#### [MODIFY] [player_bootstrap_service.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/player/services/player_bootstrap_service.dart)
- Sync `user_personalization` from local storage to `PlayerProfile` on first bootstrap if not already present.

### [Component] Riverpod Providers

#### [NEW] [selection_providers.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/features/question_content/presentation/providers/selection_providers.dart)
- `questionSelectionServiceProvider`: Provides the selection service.
- `personalizedQuestionPoolProvider`: Fetches questions based on user interests.

### [Component] Developer Preview

#### [NEW] [personalization_preview.dart](file:///C:/Users/GiftOgbonna/Joseph%20Projects/Soteria/lib/preview/personalization/personalization_preview.dart)
- Preview screen to verify selection for different user interest profiles.

## Verification Plan

### Automated Tests
- Unit tests for `QuestionSelectionService` logic.
- Unit tests for `BalancedCategoryStrategy`.
- Integration test for mapping Onboarding Interests -> Question Selection.

### Manual Verification
- Use the Developer Preview to check:
    - Single category selection.
    - Multi-category balancing.
    - Fallback when a category is empty.
    - Empty interest list fallback (General Knowledge).
