# Soteria IDE Widget Previews

The IDE Widget Preview system allows developers to visually iterate on individual screens and components rapidly, without the need for a full app launch or an emulator.

## Overview

Soteria supports two types of preview workflows:

1. **IDE Widget Previews**: Lightweight, single-widget entry points that can be run directly from the IDE.
2. **Soteria Preview Gallery**: A full-app interactive gallery (`lib/main_preview.dart`) for comprehensive testing.

## How to use IDE Previews

1. Navigate to `lib/preview/ide/`.
2. Find the preview file for the screen or component you are working on.
   - e.g., `lib/preview/ide/screens/competitive_profile_preview.dart`.
3. Click the "Run" button (green play icon) next to the `main()` function in your IDE.
4. The widget will launch in a desktop window or a connected device if available, but it will only render that specific widget with mock data.

## Creating a new Preview

To create a preview for a new widget, create a file in the appropriate subdirectory of `lib/preview/ide/` and use the `PreviewScaffold`:

```dart
import 'package:flutter/material.dart';
import '../preview_scaffold.dart';
import '../../../features/my_feature/widgets/my_widget.dart';

void main() {
  runApp(const MyWidgetPreview());
}

class MyWidgetPreview extends StatelessWidget {
  const MyWidgetPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const PreviewScaffold(
      child: MyWidget(),
    );
  }
}
```

## Previewing Riverpod Screens

If your screen depends on Riverpod providers, use the `overrides` parameter of `PreviewScaffold` to provide mock data:

```dart
return PreviewScaffold(
  overrides: [
    myProvider.overrideWithValue(MockData.value),
  ],
  child: const MyScreen(),
);
```

## Testing Responsive Layouts

You can simulate different device sizes by providing a `designSize`:

```dart
return PreviewScaffold(
  designSize: PreviewDevices.ipadPro,
  child: const MyScreen(),
);
```

Common sizes are defined in `lib/preview/ide/devices/preview_devices.dart`.

## Best Practices

- **Zero Dependencies**: Previews must never require a real Firebase initialization or Internet connection.
- **Fast Iteration**: Keep previews lightweight. Avoid complex async operations in the build method.
- **One UI Implementation**: Previews must use the same production widgets as the real app. Do not create separate "preview versions" of your UI logic.
- **State Coverage**: Create separate preview files for Loading, Empty, and Error states to ensure visual consistency across all scenarios.
