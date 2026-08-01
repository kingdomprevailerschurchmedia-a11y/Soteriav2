# Soteria - Premium Competitive Learning Platform

Soteria is a premium competitive learning platform built with Flutter, following high-end engineering standards and clean architecture.

## Architecture

This project follows **Clean Architecture** with a **Feature-first** structure:

- `lib/core`: Foundation of the application, including the design system, navigation, and services.
- `lib/features`: Independent feature modules containing their own UI and logic.
- `lib/shared`: Shared widgets and utilities used across multiple features.

## Folder Structure

```text
lib/
  core/
    app/              # Application entry and global configuration
    config/           # Environment and app configuration
    constants/        # Global constants
    design_system/    # Design tokens, themes, and atomic components
    errors/           # Error handling and custom exceptions
    extensions/       # Dart and Flutter extensions
    localization/     # Multi-language support
    logging/          # Centralized logging service
    navigation/       # App routing using GoRouter
    services/         # Core infrastructure services
    utils/            # Utility functions
    widgets/          # Core reusable widgets
  features/           # Feature-based folders
  shared/             # Shared logic and widgets
```

## Engineering Principles

- **Material 3**: Modern UI implementation.
- **Riverpod**: Robust state management.
- **GoRouter**: Declarative routing.
- **Offline-first**: Ready for local persistence.
- **Responsive**: Utilizing `flutter_screenutil` for multi-device support.

## Design System (V2)

The application uses a premium dark-only theme with high-contrast accents:

- **Primary**: #5B3FD9 (Deep Purple)
- **Secondary**: #7C4DFF (Vibrant Violet)
- **Gold**: #D8B24A (Premium Gold)
- **Background**: Multi-stage dark gradient.

## Getting Started

### Prerequisites

- Flutter SDK (Stable channel)
- Android Studio / VS Code

### Installation

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter run`

### Commands

- `flutter analyze`: Check for linting issues.
- `flutter test`: Run widget and unit tests.

## Development Standards

### "Gallery First" Rule
Every new reusable widget, screen, animation, or UI state **MUST** include a dedicated entry in the **Interactive Developer Preview Gallery** before the task can be considered complete.

This ensures:
1. All UI components are truly reusable and isolated from business logic.
2. Designers and developers can verify responsiveness and accessibility instantly.
3. The visual catalog remains a living, up-to-date source of truth.

### How to add a new Preview
1. Create a new page in `lib/features/preview_gallery/pages/` or update an existing one.
2. Define the new `GalleryItem` in `lib/features/preview_gallery/providers/gallery_providers.dart`.
3. Register the route in `lib/core/navigation/app_router.dart`, wrapping your page with `GalleryShell`.
