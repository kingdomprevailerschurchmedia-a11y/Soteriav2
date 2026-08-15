# Implementation Plan — Story 10.12: Question Quality & Scaling

Implement quality controls, analytics-driven signals, and scaling optimizations for the Soteria Question Platform while maintaining Spark-plan compatibility.

## User Review Required

> [!IMPORTANT]
> The existing `QuestionSelectionService` uses a "fetch latest and shuffle" approach. For true scaling (50,000+ questions), a more robust random selection strategy (e.g., using random offsets or sharded IDs) will be needed. I will implement a "random-seeded" selection improvement if possible without breaking the existing model, or document it as a Future Optimization.

> [!NOTE]
> I will add a `qualityFlags` field to the `Question` metadata to store automated quality signals (e.g., `near_duplicate`, `low_accuracy`, `high_timeout`) without changing the core schema.

## Proposed Changes

### [Component] Question Domain & Validation

#### [MODIFY] [question.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/question_content/domain/entities/question.dart)
- No changes to the core fields (per safety rules).

#### [MODIFY] [question_validator.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/question_content/data/validators/question_validator.dart)
- Add validation for:
    - `estimatedTime`: Must be between 5s and 120s.
    - `xpValue`: Must be between 0 and 1000.
    - `coinValue`: Must be between 0 and 100.
    - `version`: Must follow semantic versioning (basic check).
    - `timestamps`: `updatedAt` should not be before `createdAt`.
    - `explanation`: Required for `Difficulty.hard`.

---

### [Component] Analytics-Driven Quality

#### [MODIFY] [firestore_question_analytics_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/analytics/data/repositories/firestore_question_analytics_repository.dart)
- Enhance `getReviewSignals` to include:
    - `highTimeoutRate` (> 20%)
    - `highSkipRate` (> 15%)
    - `outlierResponseTime` (Avg response time > 1.5x `estimatedTime`)
    - `insufficientSample` (Attempts < 20)

---

### [Component] Scaling & Selection

#### [MODIFY] [question_repository_impl.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/question_content/data/repositories/question_repository_impl.dart)
- Implement a simple Least Recently Used (LRU) or bounded cache to prevent memory exhaustion as the bank grows.

#### [MODIFY] [question_selection_service.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/question_content/domain/selection/question_selection_service.dart)
- Optimize `selectQuestions` to reduce redundant repository calls when multiple categories are requested.

---

### [Component] Current Affairs & Content Integrity

#### [MODIFY] [import_questions.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/bin/import_questions.dart)
- Add a basic duplicate detection check that compares question text (normalized) against the existing batch.

#### [MODIFY] [publish_ready_questions.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/bin/publish_ready_questions.dart)
- Formalize the blocking of Current Affairs questions by adding a `blockedReason` to their metadata if they are identified as needing refresh.

## Verification Plan

### Automated Tests
- `flutter test test/features/question_content/data/validators/question_validator_test.dart`
- `flutter test test/features/question_content/domain/selection/question_selection_service_test.dart`
- `flutter test test/features/analytics/firestore_question_analytics_repository_test.dart`

### Manual Verification
- Run `dart bin/import_questions.dart` dry-run to verify duplicate detection.
- Run `dart bin/publish_ready_questions.dart` dry-run to verify Current Affairs blocking logic.
- Inspect `question_performance` documents in Firestore (simulated in tests) to verify quality signals.
