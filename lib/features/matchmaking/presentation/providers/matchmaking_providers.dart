import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import '../../domain/models/matchmaking_session.dart';
import '../../domain/models/matchmaking_status.dart';
import '../../domain/repositories/matchmaking_repository.dart';
import '../../data/repositories/firebase_matchmaking_repository.dart';
import '../../../player/presentation/providers/progression_providers.dart';
import '../../../player/presentation/providers/rank_providers.dart';
import '../../../question_content/domain/entities/category.dart';
import '../../../question_content/domain/repositories/category_repository.dart';
import '../../../question_content/presentation/providers/category_providers.dart';
import '../../../quiz/domain/models/quiz_enums.dart';
import '../../../player/providers/player_providers.dart';

part 'matchmaking_providers.freezed.dart';

// --- Lobby ---

@freezed
abstract class VersusLobbyState with _$VersusLobbyState {
  const factory VersusLobbyState({
    Category? category,
    @Default(Difficulty.medium) Difficulty difficulty,
    @Default(10) int questionCount,
    @Default([]) List<Category> categories,
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool useInterests,
    String? validationError,
  }) = _VersusLobbyState;
}

class VersusLobbyNotifier extends Notifier<VersusLobbyState> {
  @override
  VersusLobbyState build() {
    Future.microtask(() => _init());
    return const VersusLobbyState();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    try {
      final categories = await ref.read(categoryRepositoryProvider).getCategories();
      state = state.copyWith(
        isLoading: false,
        categories: categories,
        category: state.category ?? (categories.isNotEmpty ? categories.first : null),
      );
      _validate();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateCategory(Category category) {
    state = state.copyWith(category: category, useInterests: false);
    _validate();
  }

  void updateDifficulty(Difficulty diff) {
    state = state.copyWith(difficulty: diff);
    _validate();
  }

  void updateQuestionCount(int count) {
    state = state.copyWith(questionCount: count);
    _validate();
  }

  void setUseInterests(bool value) {
    state = state.copyWith(useInterests: value);
    if (value) {
      state = state.copyWith(category: null);
    }
    _validate();
  }

  void _validate() {
    final player = ref.read(currentPlayerProvider);
    final level = ref.read(currentCompetitiveLevelProvider);

    String? validationError;

    if (player == null) {
      validationError = 'Player profile not found';
    } else if (!state.useInterests && state.category == null) {
      validationError = 'Please select a category';
    } else if (state.difficulty == Difficulty.expert && level < 10) {
      validationError = 'Level 10 required for Expert difficulty';
    }

    state = state.copyWith(validationError: validationError);
  }
}

final versusLobbyProvider = NotifierProvider<VersusLobbyNotifier, VersusLobbyState>(
  () => VersusLobbyNotifier(),
  isAutoDispose: true,
);

// --- Matchmaking ---

final matchmakingRepositoryProvider = Provider<MatchmakingRepository>((ref) {
  return FirebaseMatchmakingRepository(
    firestore: ref.watch(firestoreProvider),
    auth: ref.watch(firebaseAuthProvider),
  );
});

final matchmakingSessionIdProvider = StateProvider<String?>((ref) => null);

final matchmakingSessionProvider = StreamProvider<MatchmakingSession?>((ref) {
  final sessionId = ref.watch(matchmakingSessionIdProvider);
  if (sessionId == null) return Stream.value(null);

  return ref.watch(matchmakingRepositoryProvider).observeSession(sessionId);
});

class MatchmakingNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // Initial check for active session
    _restoreActiveSession();
  }

  Future<void> _restoreActiveSession() async {
    final session = await ref.read(matchmakingRepositoryProvider).getActiveSession();
    if (session != null) {
      ref.read(matchmakingSessionIdProvider.notifier).state = session.sessionId;
    }
  }

  Future<void> enterQueue({
    required Map<String, dynamic> configuration,
  }) async {
    state = const AsyncValue.loading();
    try {
      final rankProgress = ref.read(rankProgressProvider).value;
      final level = ref.read(currentCompetitiveLevelProvider);

      final rankSnapshot = {
        'rankName': rankProgress?.currentRank ?? 'Bronze',
        'tier': rankProgress?.tier.name ?? 'III',
        'points': rankProgress?.currentRP ?? 0,
        'level': level,
      };

      final session = await ref.read(matchmakingRepositoryProvider).enterQueue(
            configuration: configuration,
            rankSnapshot: rankSnapshot,
          );

      ref.read(matchmakingSessionIdProvider.notifier).state = session.sessionId;
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> cancelQueue() async {
    final sessionId = ref.read(matchmakingSessionIdProvider);
    if (sessionId == null) return;

    state = const AsyncValue.loading();
    try {
      await ref.read(matchmakingRepositoryProvider).cancelQueue(sessionId);
      ref.read(matchmakingSessionIdProvider.notifier).state = null;
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> confirmReady() async {
    final sessionId = ref.read(matchmakingSessionIdProvider);
    if (sessionId == null) return;

    try {
      await ref.read(matchmakingRepositoryProvider).confirmMatch(sessionId);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final matchmakingControllerProvider = AsyncNotifierProvider<MatchmakingNotifier, void>(
  () => MatchmakingNotifier(),
  isAutoDispose: true,
);

final queueTimerProvider = StreamProvider.autoDispose<int>((ref) {
  final session = ref.watch(matchmakingSessionProvider).value;
  if (session == null || session.status != MatchmakingStatus.searching) {
    return Stream.value(0);
  }

  return Stream.periodic(const Duration(seconds: 1), (count) => count + 1);
});
