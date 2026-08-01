# Implementation Plan - Story 1.10: Epic 1 Production Certification

Perform a comprehensive engineering audit and certification of Epic 1 foundation. Fix integration issues, lint warnings, and ensure production readiness.

## User Review Required

> [!IMPORTANT]
> I will be refactoring `LoggerService` to use named parameters for `error` and `critical` methods for consistency. This will fix the compilation error in the Diagnostics page.

> [!WARNING]
> I will be updating `LogLevel.verbose` to `LogLevel.trace` and `LoggerService.v` to `LoggerService.t` to comply with the latest `logger` package version and fix lint warnings.

## Proposed Changes

### 1. Code Quality & Lint Fixes
- **[MODIFY] [logger_service.dart](file:///C:/Joseph Project/lib/core/logging/logger_service.dart)**:
    - Update `LogLevel.verbose` -> `LogLevel.trace`.
    - Update `LoggerService.v` -> `LoggerService.t`.
    - Refactor `e` and `critical` to use named parameters for `error`, `stackTrace`, `feature`, and `metadata`.
- **[MODIFY] [diagnostics_service.dart](file:///C:/Joseph Project/lib/core/services/diagnostics_service.dart)**: Use string interpolation instead of `+` for strings.
- **[MODIFY] [performance_service.dart](file:///C:/Joseph Project/lib/core/services/performance_service.dart)**: Remove unnecessary `dart:ui` import.
- **[MODIFY] [error_screens.dart](file:///C:/Joseph Project/lib/core/widgets/errors/error_screens.dart)**: Remove unused import and update `withOpacity` to `withValues`.
- **[MODIFY] [error_widgets.dart](file:///C:/Joseph Project/lib/core/widgets/errors/error_widgets.dart)**: Update `withOpacity` to `withValues`.
- **[MODIFY] [feedback_components.dart](file:///C:/Joseph Project/lib/core/widgets/feedback/feedback_components.dart)**: Update `withOpacity` to `withValues`.
- **[MODIFY] [diagnostics_preview_page.dart](file:///C:/Joseph Project/lib/features/preview_gallery/pages/diagnostics_preview_page.dart)**:
    - Update `withOpacity` to `withValues`.
    - Fix `LoggerService.critical` and `LoggerService.e` calls to use new named parameters.
- **[MODIFY] [preview_gallery_screen.dart](file:///C:/Joseph Project/lib/features/preview_gallery/preview_gallery_screen.dart)**: Update `withOpacity` to `withValues`.

### 2. Test Fixes
- **[MODIFY] [diagnostics_service.dart](file:///C:/Joseph Project/lib/core/services/diagnostics_service.dart)**: Allow re-initialization of `DiagnosticsService` (or handle it gracefully) to fix `LateInitializationError` in tests.
- **[MODIFY] [error_handling_test.dart](file:///C:/Joseph Project/test/error_handling_test.dart)**: Fix unnecessary type check lint.

### 3. Design System & Integration Audit
- **[FIX]**: Replace hardcoded `BorderRadius.circular(12)` with `SoteriaRadius.brMd` in `error_screens.dart`, `feedback_components.dart`, etc.
- **[FIX]**: Replace hardcoded `SizedBox(height: 16)` and other values with `SoteriaSpacing` tokens.
- **[FIX]**: Ensure `AppRouter` and `ErrorHandler` are fully integrated and functional.
- **[FIX]**: Remove `Colors.transparent` usage where a themed transparent color or specific token is preferred (though `Colors.transparent` is generally okay, some consistency is good). Actually, I'll focus on colors like `Colors.white.withValues(...)`.

### 4. Components Audit
- **[FIX]**: Ensure all components in `lib/core/widgets` are represented in the Preview Gallery.
- **[FIX]**: Add missing documentation (doc comments) to core components.

## Verification Plan

### Automated Tests
- Run `flutter analyze` and ensure zero issues.
- Run `flutter test` and ensure all tests pass.

### Manual Verification
- Verify the "Diagnostics" page in the Preview Gallery works without errors.
- Verify all error simulations work and show correct UIs.
- Verify responsive layout on different screen sizes (Portrait/Landscape).
- Verify dark theme consistency (no white flashes).
