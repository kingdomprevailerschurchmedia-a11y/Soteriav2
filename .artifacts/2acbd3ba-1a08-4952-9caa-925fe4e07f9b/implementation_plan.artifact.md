# Implementation Plan — Story 10.10: Pro Mode Results

Build the complete Pro Mode Results experience on top of the Pro Mode Gameplay implementation.

## User Review Required

> [!IMPORTANT]
> The authoritative validation logic in `FirestoreProModeRepository` will be updated to fetch the `CompetitiveSession` from Firestore and re-calculate results based on the authoritative question set and submitted answers, preventing client-side score spoofing.

## Proposed Changes

### Gameplay Engine - Repository & Data Layer

#### [MODIFY] [firestore_pro_mode_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart)
- Update `completeSession` to:
    - Fetch the `CompetitiveSession` doc.
    - Validate that the session belongs to the current user and is not already completed.
    - Re-calculate `score`, `accuracy`, `XP`, and `coins` using the `questions` list stored in the session and the `answerHistory` from `finalState`.
    - Resolve the `pro_reservations` state (mark as settled).
    - Use a transaction for atomicity and idempotency.

### Gameplay Engine - Models & Providers

#### [MODIFY] [pro_mode_results_provider.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/providers/pro_mode_results_provider.dart)
- Add a method/logic to fetch the `CompetitiveSession` when needed for question review if only a `sessionId` is available.
- Ensure the state correctly reflects "authoritative verification" phase.

### Gameplay Engine - UI & Presentation

#### [MODIFY] [pro_mode_results_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/pages/pro_mode_results_screen.dart)
- Implement navigation to `CompetitiveReviewScreen`.
- Ensure animations respect `MediaQuery.disableAnimations`.
- Verify accessibility (semantics for score, accuracy, etc.).
- Ensure premium visual experience (Gold theme for S/A ratings).

#### [MODIFY] [competitive_review_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/pages/competitive_review_screen.dart)
- Ensure it handles Pro Mode results correctly (showing explanations, correct/incorrect status).

### Navigation & Routing

#### [MODIFY] [soteria_routes.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/navigation/soteria_routes.dart)
- Verify `proResults` route definition and parameters.

## Verification Plan

### Automated Tests
- **Unit Tests**:
    - `pro_mode_scoring_test.dart`: Test authoritative score and reward calculation logic.
    - `pro_mode_repository_test.dart`: Test idempotency and session completion security.
- **Integration Tests**:
    - `pro_mode_e2e_test.dart`: Test full flow from Gameplay -> Results -> Review -> Exit/Replay.

### Manual Verification
- Deploy to Preview Gallery.
- Test with "Reduced Motion" enabled in system settings.
- Test with different screen sizes (Small phone, Tablet).
- Verify Firestore data consistency after session completion.
