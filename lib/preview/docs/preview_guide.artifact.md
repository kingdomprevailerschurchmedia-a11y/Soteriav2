# Soteria Developer Preview Guide

The Soteria Developer Preview System is a high-fidelity Storybook-style tool for isolated development, testing, and certification of UI components and screens.

## Quick Start

To launch the preview system, run:

```bash
flutter run -t lib/main_preview.dart
```

## Folder Structure

- `lib/preview/`: Root directory for the system.
- `lib/preview/registry/`: Central registration of all preview items.
- `lib/preview/models/`: Data models for categories and items.
- `lib/preview/widgets/`: Core UI components (Device Simulator, State Switcher).
- `lib/preview/mock/`: Fake services and repositories for offline use.
- `lib/preview/providers/`: Riverpod overrides for mock injection.

## Adding a New Preview

1.  **Create a Preview Item**: Define your component or screen within a `PreviewItem`.
2.  **Register it**: Add it to `lib/preview/registry/all_previews.dart`.

Example:

```dart
r.registerPreview(PreviewItem(
  id: 'my-component',
  title: 'My Component',
  description: 'Visual description',
  category: PreviewCategory.components,
  builder: (context) => const MyComponent(),
));
```

## Device Simulation & State Toggling

The system includes a toolbar to instantly:
- **Switch Devices**: Preview on iPhone, Pixel, Tablet, or Foldable.
- **Toggle Orientation**: Switch between Portrait and Landscape.
- **Force States**: Manually trigger `Loading`, `Success`, `Error`, `Empty`, or `Offline` views using the state switcher icons.

## Quality Tools

- **Grid Overlay**: Press the grid icon to show a standard 8dp spacing grid.
- **Semantics Debugger**: Press the voice icon to visualize screen reader boundaries and semantics labels.

## Mocking Services

All previews use `FakeAuthService` and `FakeDatabaseService` by default. You can provide granular mock data using Riverpod `overrides` within the `builder` function of a `PreviewItem`.
