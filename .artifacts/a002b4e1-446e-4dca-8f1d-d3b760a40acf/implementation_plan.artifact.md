# Implementation Plan - Practice Mode Polish, Optimization & Certification

Transform Practice Mode into a production-ready, high-performance experience with complete design system compliance and Developer Preview coverage.

## User Review Required

> [!IMPORTANT]
> **Component Unification**: I will migrate all usages of `core/widgets/buttons/soteria_button.dart` to the new `core/design_system/components/soteria_button.dart` and delete the old one to ensure a single source of truth.
> **Performance Tuning**: I will implement aggressive `.select()` usage in Riverpod watches to minimize widget rebuilds during gameplay (especially during timer ticks).

## Proposed Changes

### 1. Visual Polish & Design System Compliance
- **[MODIFY] [gameplay_progress_bar.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/widgets/gameplay_progress_bar.dart)**: Use `SoteriaRadius.brMd` and `SoteriaTypography`.
- **[MODIFY] [answer_review_card.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/widgets/answer_review_card.dart)**: Use `SoteriaRadius.brMd` and standardized typography.
- **[MODIFY] [level_progression_card.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/widgets/level_progression_card.dart)**: Refine animation curve and timing.
- **[MODIFY] [achievement_unlock_card.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/widgets/achievement_unlock_card.dart)**: Ensure token usage for radius and spacing.
- **[MODIFY] [gameplay_header_stats.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/widgets/gameplay_header_stats.dart)**: Use typography tokens for all labels.
- **[DELETE] `lib/core/widgets/buttons/soteria_button.dart`**: Replace with design system version.

### 2. Performance Optimization
- **[MODIFY] [game_playing_view.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/pages/game_playing_view.dart)**: Use `.select` to watch only necessary `GameState` fields.
- **[MODIFY] [game_shell_page.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/pages/game_shell_page.dart)**: Optimize state transitions to avoid full page rebuilds.
- **[MODIFY] [game_engine_provider.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/providers/game_engine_provider.dart)**: Implement question pre-loading logic for smoother transitions.

### 3. Developer Preview Gallery Expansion
- **[MODIFY] [mock_data_factory.dart](file:///C:/Joseph%20Project/lib/features/preview_gallery/models/mock_data_factory.dart)**: Add `NewPlayer`, `ReturningPlayer`, `ExpertPlayer`, and `OfflineSession` mock configurations.
- **[MODIFY] [results_redesign_preview.dart](file:///C:/Joseph%20Project/lib/features/preview_gallery/pages/results_redesign_preview.dart)**: Register `Perfect Score`, `Failed Session`, `Level Up`, and `Sync Pending` states.
- **[NEW] [lobby_redesign_preview.dart](file:///C:/Joseph%20Project/lib/features/preview_gallery/pages/lobby_redesign_preview.dart)**: Dedicated preview for the Practice Lobby with all configurations.

### 4. Accessibility & Responsiveness
- **[MODIFY] [question_presenter.dart](file:///C:/Joseph%20Project/lib/features/question_presentation/widgets/question_presenter.dart)**: Add comprehensive `Semantics` for the whole gameplay flow.
- **[MODIFY] [results_screen.dart](file:///C:/Joseph%20Project/lib/features/gameplay_engine/pages/results_screen.dart)**: Implement two-column layout for tablets in landscape.

### 5. Final Certification
- Run `flutter analyze` and `flutter test`.
- Generate the **Epic 5 Release Readiness Scorecard**.
- Produce documentation: Architecture, Reward Engine, and Offline Strategy.

---

## Verification Plan

### Automated Tests
- **Performance Tests**: Measure frame rendering times during transitions.
- **Golden Tests**: Verify all Gallery states on Phone and Tablet.
- **Accessibility Audit**: Run `AccessibilityGuideline` tests on the Results Screen.

### Manual Verification
- Verify 60 FPS on physical device during the XP gain animation.
- Check offline synchronization by simulating network loss during session completion.
- Validate resumed session state in the Preview Gallery.
