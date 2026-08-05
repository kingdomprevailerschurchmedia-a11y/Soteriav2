# Implementation Plan — Soteria Developer Preview System (Story 7.5)

Build a complete, reusable Developer Preview System as a permanent development tool for the Soteria project, allowing for isolated testing of any component or screen without external dependencies.

## User Review Required

> [!IMPORTANT]
> **Isolated Entry Point**: `lib/main_preview.dart` will be the exclusive entry point for the Preview System. It will NOT be included in production builds.
> **Total Mocking**: All Firebase, Auth, and Backend services will be replaced by local fakes/mocks within the `PreviewScope`.
> **Scalability**: The system is designed to handle thousands of components using an automated registration registry.

## Proposed Changes

### [Preview System Foundation]

#### [NEW] [main_preview.dart](file:///C:/Joseph%20Project/lib/main_preview.dart)
Main entry point that launches `SoteriaPreviewApp`.

#### [NEW] [preview/app/preview_app.dart](file:///C:/Joseph%20Project/lib/preview/app/preview_app.dart)
Root widget for the preview system, managing themes and top-level providers.

#### [NEW] [preview/registry/preview_registry.dart](file:///C:/Joseph%20Project/lib/preview/registry/preview_registry.dart)
Central singleton for registering categories and items.

### [Mock Infrastructure]

#### [NEW] [preview/mock/mock_auth_service.dart](file:///C:/Joseph%20Project/lib/preview/mock/mock_auth_service.dart)
#### [NEW] [preview/mock/mock_database_service.dart](file:///C:/Joseph%20Project/lib/preview/mock/mock_database_service.dart)
Fake implementations that allow the app to run offline without Firebase.

#### [NEW] [preview/providers/preview_provider_overrides.dart](file:///C:/Joseph%20Project/lib/preview/providers/preview_provider_overrides.dart)
Set of Riverpod overrides to inject mock dependencies.

### [UI Components]

#### [NEW] [preview/widgets/preview_home.dart](file:///C:/Joseph%20Project/lib/preview/widgets/preview_home.dart)
Storybook-style gallery with search and category navigation.

#### [NEW] [preview/widgets/device_simulator.dart](file:///C:/Joseph%20Project/lib/preview/widgets/device_simulator.dart)
Wrapper to simulate various device sizes (Pixel, iPhone, Tablet, Foldable).

#### [NEW] [preview/widgets/state_switcher.dart](file:///C:/Joseph%20Project/lib/preview/widgets/state_switcher.dart)
Toolbar to toggle between `Loading`, `Success`, `Error`, and `Offline` states.

### [Design System & Animation Gallery]

#### [NEW] [preview/categories/design_system/](file:///C:/Joseph%20Project/lib/preview/categories/design_system/)
Automated pages for Tokens (Colors, Typography, Spacing, Radius, Icons).

#### [NEW] [preview/categories/animations/](file:///C:/Joseph%20Project/lib/preview/categories/animations/)
Dedicated previews for motion tokens and complex animations (Confetti, Level Up).

### [Quality Tools]

#### [NEW] [preview/utilities/quality_tools.dart](file:///C:/Joseph%20Project/lib/preview/utilities/quality_tools.dart)
Tools like Spacing Overlay and Typography Viewer.

## Verification Plan

### Automated Tests
- `flutter analyze`
- `flutter test`
- **Golden Tests**: Generate baseline images for a selection of previewed components.

### Manual Verification
1.  Run `flutter run -t lib/main_preview.dart`.
2.  Verify categories are displayed correctly.
3.  Search for "Login" and "Button".
4.  Switch between "Success" and "Error" states for a screen.
5.  Simulate "Tablet" and "Landscape" orientations.
6.  Check contrast and touch target tools.
