import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/firebase/providers/firebase_providers.dart';
import '../../../core/identity/providers/identity_providers.dart';
import '../../auth/providers/auth_providers.dart';
import '../../../core/identity/models/user_profile.dart';
import '../domain/models/player_profile.dart';
import '../domain/repositories/player_repository.dart';
import '../data/repositories/firestore_player_repository.dart';
import '../domain/services/progression_service.dart';
import '../domain/use_cases/get_progression_use_case.dart';
import '../domain/use_cases/load_player_profile_use_case.dart';
import '../domain/use_cases/create_player_profile_use_case.dart';
import '../domain/use_cases/update_player_profile_use_case.dart';
import '../domain/use_cases/observe_player_profile_use_case.dart';
import '../domain/repositories/profile_repository.dart';
import '../data/repositories/firestore_profile_repository.dart';
import '../domain/models/progression.dart';
import '../domain/models/player_progression.dart';
import '../services/player_bootstrap_service.dart';
import '../presentation/providers/progression_providers.dart';
import '../presentation/providers/leaderboard_providers.dart';
import '../presentation/providers/goal_providers.dart';
import '../../question_content/presentation/providers/category_providers.dart';

import '../domain/repositories/achievement_repository.dart';
import '../data/repositories/firebase_achievement_repository.dart';
import '../domain/repositories/player_progression_repository.dart';
import '../data/repositories/firebase_player_progression_repository.dart';

import '../domain/repositories/achievement_repository.dart';
import '../data/repositories/firebase_achievement_repository.dart';
import '../domain/repositories/player_progression_repository.dart';
import '../data/repositories/firebase_player_progression_repository.dart';
import '../domain/services/competitive_ranking_engine.dart';

// --- Repositories ---
final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  return FirestorePlayerRepository(
    database: ref.watch(firestoreDatabaseServiceProvider),
  );
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return FirestoreProfileRepository(
    FirebaseFirestore.instance,
    ref.watch(leaderboardRepositoryProvider),
    ref.watch(playerProgressionRepositoryProvider),
  );
});

final achievementRepositoryProvider = Provider<AchievementRepository>((ref) {
  return FirebaseAchievementRepository(
    FirebaseFirestore.instance,
    ref.watch(playerProgressionRepositoryProvider),
    ref.watch(progressionServiceProvider),
  );
});

// --- Use Cases ---
final loadPlayerProfileUseCaseProvider = Provider(
  (ref) => LoadPlayerProfileUseCase(ref.watch(playerRepositoryProvider)),
);
final createPlayerProfileUseCaseProvider = Provider(
  (ref) => CreatePlayerProfileUseCase(ref.watch(playerRepositoryProvider)),
);
final updatePlayerProfileUseCaseProvider = Provider(
  (ref) => UpdatePlayerProfileUseCase(ref.watch(playerRepositoryProvider)),
);
final observePlayerProfileUseCaseProvider = Provider(
  (ref) => ObservePlayerProfileUseCase(ref.watch(playerRepositoryProvider)),
);

final getProgressionUseCaseProvider = Provider(
  (ref) => GetProgressionUseCase(ref.watch(progressionServiceProvider)),
);

// --- Services ---
final playerBootstrapServiceProvider = Provider(
  (ref) => PlayerBootstrapService(
    ref.watch(loadPlayerProfileUseCaseProvider),
    ref.watch(createPlayerProfileUseCaseProvider),
    ref.watch(updatePlayerProfileUseCaseProvider),
    ref.watch(playerProgressionRepositoryProvider),
    ref.watch(progressionServiceProvider),
    FirebaseFirestore.instance,
    identityRepository: ref.watch(identityRepositoryProvider),
    categoryRepository: ref.watch(categoryRepositoryProvider),
    goalRepository: ref.watch(goalRepositoryProvider),
    leaderboardRepository: ref.watch(leaderboardRepositoryProvider),
  ),
);

// --- State Providers ---

/// A stream of the current player's profile, providing real-time updates.
final currentPlayerStreamProvider = StreamProvider<PlayerProfile?>((ref) {
  final session = ref.watch(sessionProvider);

  if (!session.isAuthenticated || session.uid == null) {
    return Stream.value(null);
  }

  return ref.watch(observePlayerProfileUseCaseProvider).execute(session.uid!);
});

/// A convenience provider to access the current player profile data.
/// Returns the latest data available, even during refresh states, to prevent UI flickering.
final currentPlayerProvider = Provider<PlayerProfile?>((ref) {
  final asyncValue = ref.watch(currentPlayerStreamProvider);
  return asyncValue.value;
});

/// Progression state for the current player.
final playerProgressionProvider = Provider<Progression>((ref) {
  final player = ref.watch(currentPlayerProvider);
  return ref.watch(getProgressionUseCaseProvider).execute(player);
});

/// Manages the bootstrap process state.
final playerBootstrapStatusProvider = FutureProvider<void>((ref) async {
  final authUser = ref.watch(authDataSourceProvider).currentUser;
  if (authUser != null) {
    await ref.read(playerBootstrapServiceProvider).bootstrap(authUser);
  }
});

final playerLeaderboardSyncProvider = Provider<void>((ref) {
  // Listen to profile changes
  ref.listen<PlayerProfile?>(currentPlayerProvider, (previous, next) {
    if (next != null) {
      _sync(ref, next);
    }
  });

  // Listen to progression changes (which includes XP and Rank)
  ref.listen<AsyncValue<PlayerProgression>>(competitiveProgressionProvider,
      (previous, next) {
    final player = ref.read(currentPlayerProvider);
    if (player != null && next.hasValue) {
      _sync(ref, player, progression: next.value);
    }
  });
});

Future<void> _sync(Ref ref, PlayerProfile profile,
    {PlayerProgression? progression}) async {
  final prog = progression ?? ref.read(competitiveProgressionProvider).value;
  if (prog == null) return;

  final leaderboardRepo = ref.read(leaderboardRepositoryProvider);

  // Sync Global
  await leaderboardRepo.syncLeaderboardEntry(
    profile: profile,
    progression: prog,
    seasonId: null,
  );

  // Sync Seasonal
  await leaderboardRepo.syncLeaderboardEntry(
    profile: profile,
    progression: prog,
    seasonId: prog.seasonId,
  );
}

/// A provider that synchronizes the avatar selection and profile picture between [UserProfile] and [PlayerProfile].
/// This ensures that changes made in the [AvatarSelectionDialog] are reflected across both identity models.
final playerAvatarSyncProvider = Provider<void>((ref) {
  // Listen to profile changes
  ref.listen<UserProfile?>(profileProvider, (previous, next) async {
    if (next == null) return;

    final player = ref.read(currentPlayerProvider);
    if (player == null) return;

    bool needsUpdate = false;
    final Map<String, dynamic> updates = {};

    // Sync Avatar ID (including empty string when clearing)
    if (next.selectedAvatarId != player.selectedAvatarId) {
      updates['selectedAvatarId'] = next.selectedAvatarId;
      needsUpdate = true;
    }

    // Sync Photo URL (including empty string when clearing)
    if (next.avatarUrl != player.photoUrl) {
      updates['photoUrl'] = next.avatarUrl;
      needsUpdate = true;
    }

    if (needsUpdate) {
      final now = DateTime.now();
      updates['updatedAt'] = now.toIso8601String();

      final updatedPlayer = player.copyWith(
        selectedAvatarId: next.selectedAvatarId,
        photoUrl: next.avatarUrl ?? '',
        updatedAt: now,
      );

      // 1. Update Player Profile in Firestore
      await ref
          .read(playerRepositoryProvider)
          .patchPlayerProfile(player.uid, updates);

      // 2. Sync to Leaderboard (Global & Seasonal)
      await _sync(ref, updatedPlayer);

      // 3. Invalidate Leaderboard providers to ensure UI sees the new avatar
      ref.invalidate(leaderboardControllerProvider(null));
      final seasonId = ref.read(currentSeasonIdProvider);
      if (seasonId != null) {
        ref.invalidate(leaderboardControllerProvider(seasonId));
      }
      ref.invalidate(playerLeaderboardEntryProvider);
      ref.invalidate(leaderboardAroundPlayerProvider);
    }
  });
});
