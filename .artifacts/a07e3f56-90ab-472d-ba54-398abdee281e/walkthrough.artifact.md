# Walkthrough — Soteria Developer Preview System (Story 7.5)

Implemented a permanent, high-fidelity development tool that allows for isolated building and testing of any UI component or screen without external dependencies.

## Key Components

### Isolated Architecture
- **Isolated Entry Point**: Created `lib/main_preview.dart`. Run with `flutter run -t lib/main_preview.dart`.
- **Registry System**: Implemented `PreviewRegistry` to handle automatic discovery of preview items.
- **Zero Impact**: The system resides in `lib/preview/` and is strictly excluded from production builds.

### Developer Experience (DX)
- **Storybook-style Gallery**: A sleek home screen with instant search and categorical navigation.
- **Device Simulator**: Built-in simulator for Small Phones, iPhones, Pixels, Tablets, and Foldables. Supports landscape orientation.
- **State Switcher**: Instant toggling between `Loading`, `Success`, `Error`, `Empty`, and `Offline` states for any screen.

### Quality & Diagnostics Tools
- **Spacing Grid**: Visual 8dp overlay to verify alignment.
- **Semantics Inspector**: Real-time visualization of screen reader labels and boundaries.
- **Token Viewer**: Automatic listing of all Colors, Typography, and Spacing tokens.

### Mock Infrastructure
- **Fake Services**: Implemented `FakeAuthService` and `FakeDatabaseService` to allow the entire app to run offline.
- **Riverpod Overrides**: Established a pattern for injecting mock dependencies without touching production code.

## Verification Results

### Automated Checks
- `flutter analyze`: **PASSED** (0 Errors).
- `flutter test`: **PASSED**.

### Registered Previews
- **Design System**: Tokens (Colors, Typography, Spacing).
- **Screens**: Splash, Onboarding, Pro Lobby, Tournament Discovery, Tournament Lobby, Tournament Results, Tournament Leaderboard.
- **Components**: Competitive Review Dialog.

## Future Protocol
From Epic 8 forward, every feature must be registered in this system to be considered "Complete".
