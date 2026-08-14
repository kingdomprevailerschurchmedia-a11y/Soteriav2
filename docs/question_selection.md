# Question Selection & Personalization

This document describes how user interests are connected to the Question Platform for personalized question selection.

## User Interests Mapping
Selected interests from onboarding (labels like "Science") are mapped to canonical Category IDs (slugs like "science") using the `PersonalizationBridge` utility.

## Question Selection Request
Selection is driven by `QuestionSelectionRequest`, which includes:
- `categoryIds`: List of categories to pull from.
- `difficulty`: Optional filter for difficulty level.
- `questionCount`: Number of questions requested.
- `excludedQuestionIds`: IDs to avoid (for deduplication).
- `mode`: The game mode context.

## Selection Logic
The `QuestionSelectionService` orchestrates the selection process:
1. **Pool Building**: Fetches questions for all requested categories.
2. **Exclusion**: Removes excluded IDs.
3. **Balancing**: If multiple categories are requested, `BalancedCategoryStrategy` ensures a round-robin distribution.
4. **Fallback**: If no interests are provided, it defaults to `general-knowledge`. If preferred categories are empty, it attempts to fetch from the general pool.

## Personalization Flow
1. User selects interests during Onboarding/Personalization.
2. Interests are saved locally in `SharedPreferences`.
3. Upon registration/bootstrap, `PlayerBootstrapService` syncs these interests to the `PlayerProfile` in Firestore.
4. Game modes use `personalizedQuestionSelectionProvider` which automatically pulls categories from the active user's profile if none are specified in the request.

## Security
Correct answers are NEVER included in the selection payload for competitive modes. The selection layer respects the authoritative stripping logic in the Repository/Data Source.
