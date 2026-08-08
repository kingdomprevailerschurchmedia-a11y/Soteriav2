# Implementation Plan - Quiz Engine Foundation & Architecture

Build the foundation architecture for the Soteria Quiz Engine, establishing all models, repositories, controllers, providers, and state objects required for future quiz features.

## User Review Required

> [!IMPORTANT]
> This architecture introduces **Freezed** and **JsonSerializable** for immutable models and efficient serialization, which is a shift from existing plain immutable classes like `PlayerProfile`.

## Proposed Changes

### Dependencies
- Add `freezed_annotation`, `json_annotation` to `dependencies`.
- Add `freezed`, `json_serializable` to `dev_dependencies`.

### Quiz Feature Structure
- Create `lib/features/quiz/` with the following sub-folders:
    - `data/datasource/`, `data/dto/`, `data/mapper/`, `data/repository/`
    - `domain/models/`, `domain/repositories/`, `domain/usecases/`
    - `presentation/controllers/`, `presentation/providers/`, `presentation/states/`
    - `preview/widgets/`

### Domain Enums
Create `lib/features/quiz/domain/models/quiz_enums.dart`:
- `Difficulty`: easy, medium, hard, expert
- `QuestionType`: multipleChoice, trueFalse, image, audio, video, fillBlank, ordering
- `QuizStatus`: idle, loading, ready, active, paused, completed, failed
- `GameMode`: practice, pro, tournament, versus

### Freezed Domain Models
Create the following models in `lib/features/quiz/domain/models/`:
- `Question`: Supporting metadata, XP, coins, and future question types.
- `AnswerOption`: ID, text, optional image, correct flag.
- `PlayerAnswer`: Track question ID, selected option, correctness, and response time.
- `QuizSession`: Lifecycle data, score, streak, and progression.
- `QuizResult`: Final statistics, achievements, and rank.
- `TimerState`: Duration tracking and status.
- `PowerUpState`: Availability and usage for 50/50, Pause Timer, etc.
- `QuizMetadata`, `QuestionCategory`, `DifficultySettings`.

### Repository Contract
Create `lib/features/quiz/domain/repositories/quiz_repository.dart`:
- Abstract class `QuizRepository` with methods for session management, answer submission, and scoring.

### Use Cases
Create the following in `lib/features/quiz/domain/usecases/`:
- `LoadQuestionsUseCase`, `CreateQuizSessionUseCase`, `SubmitAnswerUseCase`, `FinishQuizUseCase`, etc.

### Presentation Layer
- `QuizState`: Consolidated Freezed state for the engine.
- `QuizController`: Riverpod `Notifier` managing the quiz lifecycle and state transitions.
- `QuizProviders`: Export providers for repository, controller, and specialized states (Timer, Power-ups).

### Preview System
- Register `QuizEngine` states and mock scenarios in the `Preview Gallery`.

## Verification Plan

### Automated Tests
- Run `flutter pub run build_runner build` to generate Freezed and JsonSerializable code.
- Run `flutter analyze` to ensure architectural integrity.
- Run `flutter test` to verify zero regressions.

### Manual Verification
- Verify the new `Quiz Engine` category appears in the `Preview Gallery`.
- Inspect the generated documentation for model relationships and repository flow.
