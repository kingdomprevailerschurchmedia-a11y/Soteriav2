# Architecture Health Report — Firebase Platform Integration

This report evaluates the compliance of the Firebase integration with Soteria's Clean Architecture principles.

## 1. Layer Separation (Score: 100/100)
- **Presentation**: UI widgets (`lib/features/*/screens`) communicate only with `Notifier`s and `UseCases`. No `firebase_*` packages are imported in the presentation layer.
- **Domain**: Domain models and `UseCase` classes are pure Dart. They define the business logic (e.g., `SignInUseCase`, `BootstrapPlayerProfileUseCase`) without SDK dependencies.
- **Data**: All Firebase SDK interactions are isolated within `DataSources` (e.g., `FirebaseAuthDataSource`) and `Repositories` (e.g., `FirestorePlayerRepository`).

## 2. Dependency Rule (Score: 100/100)
- Dependencies point inwards. High-level modules (Gameplay Engine, Identity) do not depend on low-level Firebase implementations.
- Feature modules depend on `IAuthService`, `IDatabaseService` interfaces defined in `core/firebase/services`.

## 3. Dependency Injection (Score: 95/100)
- Riverpod is used exclusively for service registration.
- **Refinement**: Some providers in `features/auth/providers` were using positional arguments instead of named ones during refactor, which has been corrected.

## 4. Gameplay Engine Independence
- **Status**: VERIFIED.
- The `gameplay_engine` remains completely backend-agnostic. It receives configuration (timers, points) via the `AppConfiguration` domain model, which is supplied by the Firebase layer but does not depend on it.

## 5. Technical Debt
- **High**: Test suite needs `MockFirebase` implementation to resolve `[core/no-app]` errors during widget tests.
- **Medium**: Cleanup of deprecated `androidProvider` in `SecurityCoordinator` (blocked by SDK type mismatch in current environment).
