# Implementation Plan - Epic 5 Story 5.1: Practice Lobby & Session Initialization

Build a premium Practice Lobby that allows players to configure their quiz sessions, initializes the gameplay engine, and prepares all necessary services.

## User Review Required

> [!IMPORTANT]
> **Adaptive Difficulty**: The architecture will support an `Adaptive` mode. For now, this will fallback to `Intermediate` until the player performance tracking engine is fully implemented in later stories.

> [!TIP]
> **Reward Multipliers**: XP and Coin estimations will be driven by Firebase Remote Config multipliers (e.g., `xp_mult_advanced: 1.5`), allowing live balancing without app updates.

## Proposed Changes

### Infrastructure & Clean Up

#### [FIX] [app_router.dart](file:///C:/Joseph%20Project/lib/core/navigation/app_router.dart)
- Resolve remaining Git merge conflicts to ensure stable navigation to the Practice Lobby.

---

### Domain Layer (Models & Logic)

#### [NEW] [category.dart](file:///C:/Joseph%20Project/lib/features/question_content/domain/entities/category.dart)
- Model for quiz categories (id, name, description, icon, difficulty level).

#### [NEW] [practice_session_config.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/models/practice_session_config.dart)
- Reusable model for session parameters (category, difficulty, count, timerEnabled).

#### [NEW] [practice_session.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/models/practice_session.dart)
- Represents an initialized session with `sessionId`, `config`, and `startTime`.

#### [NEW] [session_validator.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/services/session_validator.dart)
- Pure logic service to verify configuration eligibility (e.g., "Is player level high enough for Advanced?").

#### [NEW] [reward_estimator.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/services/reward_estimator.dart)
- Calculates potential rewards based on config and Remote Config multipliers.

---

### Data Layer (Repositories)

#### [NEW] [category_repository.dart](file:///C:/Joseph%20Project/lib/features/question_content/domain/repositories/category_repository.dart)
- Interface for fetching available quiz categories.

#### [NEW] [firestore_category_repository.dart](file:///C:/Joseph%20Project/lib/features/question_content/data/repositories/firestore_category_repository.dart)
- Firestore implementation with local caching support.

#### [NEW] [practice_repository.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/domain/repositories/practice_repository.dart)
- Interface for session creation and metadata storage.

---

### Presentation Layer (State Management)

#### [NEW] [practice_lobby_providers.dart](file:///C:/Joseph%20Project/lib/features/dashboard/presentation/providers/practice_lobby_providers.dart)
- `sessionConfigProvider`: StateNotifier for user selections.
- `practiceLobbyStateProvider`: Combines categories, profile, and validation logic.
- `practiceSessionProvider`: Handles the async initialization of the game session.

---

### Presentation Layer (UI Components)

#### [NEW] [practice_lobby_screen.dart](file:///C:/Joseph%20Project/lib/features/dashboard/presentation/screens/practice_lobby_screen.dart)
- Main lobby container with glassmorphic background and entrance animations.

#### [NEW] [category_grid.dart](file:///C:/Joseph%20Project/lib/features/dashboard/presentation/widgets/lobby/category_grid.dart)
- Visual selector for quiz topics with horizontal scrolling and selection feedback.

#### [NEW] [config_selectors.dart](file:///C:/Joseph%20Project/lib/features/dashboard/presentation/widgets/lobby/config_selectors.dart)
- Custom chips and sliders for Difficulty and Question Count.

#### [NEW] [session_summary_card.dart](file:///C:/Joseph%20Project/lib/features/dashboard/presentation/widgets/lobby/session_summary_card.dart)
- Premium card showing estimated rewards and duration.

---

## Verification Plan

### Automated Tests
- **Unit Tests**: `SessionValidator` rules and `RewardEstimator` math.
- **Provider Tests**: Verify `sessionConfigProvider` correctly updates summary when choices change.
- **Golden Tests**: Lobby UI in Loading, Ready, and Error states.

### Manual Verification
- **Category Load**: Verify categories are fetched from Firestore and cached for offline use.
- **Initialization**: Tap "START PRACTICE" and verify it navigates to the (placeholder) Question screen after session creation.
- **Responsiveness**: Verify the grid layout adjusts for Tablet and Landscape modes.
