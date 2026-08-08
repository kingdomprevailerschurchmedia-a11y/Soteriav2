# Task Checklist - Quiz Engine Foundation & Architecture

- [ ] `[/]` **Feature Infrastructure**
    - [ ] `[ ]` Update `pubspec.yaml` with Freezed and JsonSerializable
    - [ ] `[ ]` Create folder structure for `lib/features/quiz/`

- [ ] `[/]` **Domain Layer (Models & Enums)**
    - [ ] `[ ]` Implement `QuizEnums` (Difficulty, QuestionType, etc.)
    - [ ] `[ ]` Implement `AnswerOption` model
    - [ ] `[ ]` Implement `Question` model
    - [ ] `[ ]` Implement `PlayerAnswer` model
    - [ ] `[ ]` Implement `TimerState` & `PowerUpState` models
    - [ ] `[ ]` Implement `QuizSession` & `QuizResult` models

- [ ] `[/]` **Domain Layer (Contracts & Logic)**
    - [ ] `[ ]` Define `QuizRepository` interface
    - [ ] `[ ]` Implement Use Cases (Create, Load, Submit, Finish, etc.)

- [ ] `[/]` **Presentation Layer**
    - [ ] `[ ]` Implement `QuizState` (Freezed)
    - [ ] `[ ]` Implement `QuizController` (Riverpod Notifier)
    - [ ] `[ ]` Define Quiz Providers

- [ ] `[/]` **Preview & Verification**
    - [ ] `[ ]` Register Quiz Engine in Preview Gallery
    - [ ] `[ ]` Run build_runner to generate code
    - [ ] `[ ]` Run analyzer and tests
