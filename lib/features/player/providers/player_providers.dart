import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/firebase/providers/firebase_providers.dart';
import '../../../core/identity/providers/identity_providers.dart';
import '../../auth/providers/auth_providers.dart';
import '../domain/models/player_profile.dart';
import '../domain/repositories/player_repository.dart';
import '../data/repositories/firestore_player_repository.dart';
import '../domain/services/progression_service.dart';
import '../domain/use_cases/get_progression_use_case.dart';
import '../domain/use_cases/load_player_profile_use_case.dart';
import '../domain/use_cases/create_player_profile_use_case.dart';
import '../domain/use_cases/update_player_profile_use_case.dart';
import '../domain/use_cases/observe_player_profile_use_case.dart';
import '../domain/models/progression.dart';
import '../domain/models/player_statistics.dart';
import '../services/player_bootstrap_service.dart';

// --- Repositories ---
final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  return FirestorePlayerRepository(
    database: ref.watch(firestoreDatabaseServiceProvider),
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

final progressionServiceProvider = Provider((ref) => ProgressionService());

final getProgressionUseCaseProvider = Provider(
  (ref) => GetProgressionUseCase(ref.watch(progressionServiceProvider)),
);

// --- Services ---
final playerBootstrapServiceProvider = Provider(
  (ref) => PlayerBootstrapService(
    ref.watch(loadPlayerProfileUseCaseProvider),
    ref.watch(createPlayerProfileUseCaseProvider),
    ref.watch(updatePlayerProfileUseCaseProvider),
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
final currentPlayerProvider = Provider<PlayerProfile?>((ref) {
  return ref.watch(currentPlayerStreamProvider).value;
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
