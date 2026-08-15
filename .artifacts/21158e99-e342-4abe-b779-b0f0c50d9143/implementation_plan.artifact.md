# Fix Pro Mode Availability Logic and Feedback

The user is encountering "NOT ENOUGH QUESTIONS AVAILABLE" in Pro Mode even though Practice Mode works. This is due to Pro Mode's strict minimum count validation (10 questions) and potential content gaps in specific difficulty levels.

## User Review Required

> [!IMPORTANT]
> Pro Mode requires a minimum of 10 questions of the **exact** selected difficulty to be in the `published` state. Practice Mode currently allows playing with fewer than requested if the pool is small.

## Proposed Changes

### Gameplay Engine

#### [MODIFY] [firestore_pro_mode_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart)
- Ensure the `getAvailableQuestionCount` query is logging correctly to help debug content gaps.

### Dashboard Feature

#### [MODIFY] [pro_lobby_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/providers/pro_lobby_providers.dart)
- Update `ProModeAccessResult` to include the `available` vs `required` counts in the error message for better developer/user feedback.

#### [MODIFY] [pro_lobby_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/screens/pro_lobby_screen.dart)
- Update `_getErrorMessage` to display the specific number of questions available when content is insufficient.

## Verification Plan

### Automated Tests
- Run `dart run bin/verify_pro_availability.dart` to check Firestore counts.
- Run unit tests for `ProLobbyNotifier` validation logic.

### Manual Verification
1. Open Pro Mode Lobby.
2. Select "Expert" (which likely has 0 questions).
3. Verify the error message now says "ONLY 0 QUESTIONS AVAILABLE (10 REQUIRED)".
4. Select "Intermediate" and verify if the session can start based on actual Firestore counts.
