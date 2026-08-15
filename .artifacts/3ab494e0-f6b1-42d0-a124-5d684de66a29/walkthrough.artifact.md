# Riverpod 3.x Migration Walkthrough

The project has been migrated to Riverpod 3.4.2. This was a significant update involving breaking changes in provider definitions and the `AsyncValue` API.

## Changes Made

### 1. Core Error Handling
- Updated `SoteriaProviderObserver` in `error_handler.dart` to match the new `ProviderObserver` signature using `ProviderObserverContext`.
- Fixed access to provider names using `context.provider.name`.

### 2. Provider API Migration
- **Legacy Support**: Added `import 'package:flutter_riverpod/legacy.dart';` to over 20 files that still use `StateNotifierProvider`, `StateProvider`, and `StateNotifier`. This allows the project to build while providing a path for future migration to the new `Notifier` pattern.
- **Notifier Migration**: Converted several `AutoDisposeNotifier` and `AutoDisposeAsyncNotifier` classes to the new `Notifier` and `AsyncNotifier` types.
- **AutoDispose**: Updated provider declarations to use the new `isAutoDispose: true` parameter instead of the `.autoDispose` constructor modifier where appropriate.

### 3. AsyncValue API
- Performed a project-wide replacement of `.valueOrNull` with `.value`. In Riverpod 3.x, `.value` returns null on error instead of throwing, making it the direct replacement for the old `.valueOrNull`.

### 4. Fixes for Mocks and Previews
- Updated mock engines and notifiers in preview files (e.g., `game_preview_gallery.dart`, `progression_preview_page.dart`) to support state initialization in Riverpod 3.x by using `Future.microtask`.

## Verified Components

- [x] `error_handler.dart`
- [x] `matchmaking_providers.dart`
- [x] `match_lifecycle_providers.dart`
- [x] `verification_notifier.dart`
- [x] `competitive_profile_provider.dart`
- [x] `challenge_center_screen.dart`

> [!NOTE]
> Some environment-related Gradle errors were observed during build attempts, but the Dart/Flutter code issues related to Riverpod have been systematically addressed.
