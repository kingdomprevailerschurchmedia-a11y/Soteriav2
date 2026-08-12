# Soteria Avatar Platform Implementation Plan

Implement a production-ready, scalable Avatar Platform for Soteria, integrating scholar avatars throughout the application.

## User Review Required

> [!IMPORTANT]
> - **Schema Change**: `UserProfile` and `PlayerProfile` will now store `selectedAvatarId` instead of just `avatarUrl`.
> - **Consolidation**: Existing `SoteriaAvatar` widgets will be unified into a single, modular implementation in `lib/core/avatar/`.
> - **Asset Registration**: `pubspec.yaml` will be updated to include `assets/avatars/`.

## Proposed Changes

### Core Avatar Module

#### [NEW] [avatar.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/avatar/domain/avatar.dart)
Define the strongly typed `Avatar` model, `AvatarCategory`, and `AvatarRarity`.

#### [NEW] [avatar_catalog.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/avatar/data/avatar_catalog.dart)
Central source of truth mapping `avatarId` to metadata and asset paths.

#### [NEW] [avatar_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/avatar/providers/avatar_providers.dart)
Riverpod providers for accessing the catalog and the user's selected avatar.

---

### Presentation Layer

#### [NEW] [soteria_avatar.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/avatar/presentation/widgets/soteria_avatar.dart)
Unified reusable avatar widget supporting frames, ranks, status indicators, and glow effects.

#### [NEW] [avatar_frame.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/avatar/presentation/widgets/avatar_frame.dart)
Reusable frame treatments (Default, Purple, Gold, Silver, Bronze, Premium).

#### [NEW] [avatar_selection_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/avatar/presentation/screens/avatar_selection_screen.dart)
Premium selection UI for browsing and equipping avatars.

---

### Identity & Persistence Integration

#### [MODIFY] [user_profile.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/identity/models/user_profile.dart)
Add `selectedAvatarId` to the `UserProfile` model.

#### [MODIFY] [player_profile.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/domain/models/player_profile.dart)
Ensure consistency with `selectedAvatarId`.

#### [MODIFY] [firebase_identity_repository.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/identity/repositories/firebase_identity_repository.dart)
Persist `selectedAvatarId` to Firestore.

---

### Feature Integration

#### [MODIFY] [top_scholars_section.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/dashboard/presentation/widgets/top_scholars_section.dart)
Replace hard-coded scholar representations with `SoteriaAvatar` resolved by `avatarId`.

#### [MODIFY] [leaderboard_row.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/player/presentation/widgets/leaderboard_row.dart)
Integrate `SoteriaAvatar` with rank-aware frames.

#### [MODIFY] [tournament_lobby_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/tournaments/presentation/screens/tournament_lobby_screen.dart)
Update player identities to use the new avatar system.

---

### Developer Experience

#### [NEW] [avatar_gallery_screen.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/preview/ide/screens/avatar_gallery_screen.dart)
Auto-discovering gallery for the Developer Preview System.

---

### Configuration

#### [MODIFY] [pubspec.yaml](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/pubspec.yaml)
Register `assets/avatars/` directory.

## Verification Plan

### Automated Tests
- Unit tests for `AvatarCatalog` and `Avatar` model.
- Widget tests for `SoteriaAvatar` permutations.
- Golden tests for frame treatments.
- Integration test for selection persistence.

### Manual Verification
- Deploy to emulator/device.
- Verify avatar selection flow in Profile.
- Verify avatars in Top Scholars, Leaderboards, and Tournaments.
- Check Preview Gallery for all avatar states.
- Verify logout/login isolation.
