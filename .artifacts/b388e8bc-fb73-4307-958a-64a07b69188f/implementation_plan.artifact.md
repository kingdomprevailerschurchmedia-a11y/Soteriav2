# Implementation Plan - Quiz Engine Foundation & Architecture

This plan establishes the core architecture for the Soteria Quiz Engine following Clean Architecture, Feature-first structure, and Riverpod state management. It covers all models, repositories, controllers, and providers required for future gameplay features.

## User Review Required

> [!IMPORTANT]
> This story focuses purely on **architecture and foundation**. No gameplay UI will be implemented. The architecture is designed to be highly scalable, supporting multiple game modes and future extensions like AI challenges and multiplayer.

> [!WARNING]
> Existing files in `lib/features/quiz` will be updated to fully comply with the new requirements.

## Proposed Changes

### Domain Layer

#### [MODIFY] [quiz_enums.dart](file:///C:/Joseph Project/lib/features/quiz/domain/models/quiz_enums.dart)
- Ensure all requested enums are present: `Difficulty`, `QuestionType`, `QuizStatus`, `GameMode`.

#### [MODIFY] [question.dart](file:///C:/Joseph Project/lib/features/quiz/domain/models/question.dart)
- Align fields with requirements: `estimatedTime`, `xpValue`, `coinValue`, etc.

#### [NEW] [question_category.dart](file:///C:/Joseph Project/lib/features/quiz/domain/models/question_category.dart)
- Create `QuestionCategory` model with ID, name, icon, description, and metadata.

#### [NEW] [difficulty_settings.dart](file:///C:/Joseph Project/lib/features/quiz/domain/models/difficulty_settings.dart)
- Create `DifficultySettings` model to define XP multipliers, time limits, and complexity for each difficulty level.

#### [MODIFY] [quiz_session.dart](file:///C:/Joseph Project/lib/features/quiz/domain/models/quiz_session.dart)
- Ensure all tracking fields are present: `xpEarned`, `coinsEarned`, `remainingQuestions`, etc.

#### [MODIFY] [quiz_result.dart](file:///C:/Joseph Project/lib/features/quiz/domain/models/quiz_result.dart)
- Ensure all storage fields are present: `accuracy`, `averageResponseTime`, `performanceGrade`, etc.

#### [NEW] Use Cases
- Add missing use cases to `lib/features/quiz/domain/usecases/`:
    - [calculate_score_use_case.dart](file:///C:/Joseph Project/lib/features/quiz/domain/usecases/calculate_score_use_case.dart)
    - [restore_session_use_case.dart](file:///C:/Joseph Project/lib/features/quiz/domain/usecases/restore_session_use_case.dart)
    - [save_progress_use_case.dart](file:///C:/Joseph Project/lib/features/quiz/domain/usecases/save_progress_use_case.dart)
    - [validate_answer_use_case.dart](file:///C:/Joseph Project/lib/features/quiz/domain/usecases/validate_answer_use_case.dart)

### Data Layer

#### [NEW] Data Sources
- [quiz_remote_data_source.dart](file:///C:/Joseph Project/lib/features/quiz/data/datasource/quiz_remote_data_source.dart) (Interface)
- [quiz_local_data_source.dart](file:///C:/Joseph Project/lib/features/quiz/data/datasource/quiz_local_data_source.dart) (Interface)

#### [NEW] [quiz_repository_impl.dart](file:///C:/Joseph Project/lib/features/quiz/data/repository/quiz_repository_impl.dart)
- Implementation of `QuizRepository` contract using data sources.

#### [NEW] Mappers & DTOs
- Create DTOs for Question and Session to decouple domain models from external data formats.

### Presentation Layer

#### [MODIFY] [quiz_controller.dart](file:///C:/Joseph Project/lib/features/quiz/presentation/controllers/quiz_controller.dart)
- Complete the controller implementation: `start`, `restore`, `submit`, `skip`, `pause`, `resume`, `finish`, `reset`, `updateScore`, `updateStreak`.

#### [MODIFY] [quiz_state.dart](file:///C:/Joseph Project/lib/features/quiz/presentation/states/quiz_state.dart)
- Ensure state includes `powerUps`, `timer`, `isOffline`, and `error` handling.

#### [MODIFY] [quiz_providers.dart](file:///C:/Joseph Project/lib/features/quiz/presentation/providers/quiz_providers.dart)
- Define all necessary Riverpod providers for repositories, use cases, and controllers.

### Preview System

#### [MODIFY] [quiz_engine_preview.dart](file:///C:/Joseph Project/lib/features/quiz/preview/quiz_engine_preview.dart)
- Register various states: `Loading`, `Empty`, `Offline`, `Error`, `Success`, `ActiveSession`.

## Verification Plan

### Automated Tests
- Run `flutter test` to ensure model serialization and repository logic are correct.
- Run `flutter analyze` to ensure zero warnings.

### Manual Verification
- Verify that all states are correctly displayed in the `QuizEnginePreview` within the Soteria Preview Gallery.
- Run `flutter run` to ensure the production app launches successfully.
