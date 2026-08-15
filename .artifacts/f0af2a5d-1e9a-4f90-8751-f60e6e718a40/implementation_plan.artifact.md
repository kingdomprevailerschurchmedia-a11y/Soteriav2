# Pro Mode Production Availability Investigation - Plan

Investigate and fix the issue where Pro Mode reports "NOT ENOUGH QUESTIONS AVAILABLE" for Any Category + Intermediate difficulty (10 questions), despite 14 questions being available in production.

## User Review Required

> [!IMPORTANT]
> The investigation revealed that `QuestionSelectionService` incorrectly defaults to the `general-knowledge` category when "Any Category" is selected. This restricts the available question pool significantly.

> [!WARNING]
> The `ProLobbyNotifier` does not perform an initial availability check upon entering the lobby. The error only appears after an interaction or a failed session initialization. This leads to a confusing user experience.

> [!NOTE]
> There is a potential discrepancy between the `status` of production questions (`approved` vs `published`). The mobile application strictly filters for `published` status.

## Proposed Changes

### Core Question Selection

#### [MODIFY] [question_selection_service.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/question_content/domain/selection/question_selection_service.dart)
- Remove the hardcoded `general-knowledge` fallback when `categoryIds` is empty.
- Ensure that if `categoryIds` is empty, the service fetches questions from all categories.
- Update the fallback logic to attempt a global search if the initial (category-specific) search yields no results, regardless of whether categories were originally specified.

---

### Pro Mode Presentation

#### [MODIFY] [pro_lobby_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/providers/pro_lobby_providers.dart)
- Update the `ProLobbyNotifier.build()` method to trigger an initial `_checkAvailability()` call.
- This ensures the UI accurately reflects content availability as soon as the user enters the Pro Lobby.

---

## Verification Plan

### Automated Tests
- Run `flutter test test/features/question_content/domain/selection/question_selection_service_test.dart` to ensure selection logic is correct.
- Run `flutter test test/features/dashboard/pro_lobby_notifier_test.dart` to verify state transitions.

### Manual Verification
- Deploy the app and navigate to the Pro Lobby.
- Verify that "Any Category + Intermediate (10 questions)" now displays "AVAILABLE" (assuming at least 10 `published` medium questions exist).
- Verify that "Any Category + Expert (10 questions)" correctly displays "NOT ENOUGH QUESTIONS AVAILABLE" (as only 4 are available per previous audit).
