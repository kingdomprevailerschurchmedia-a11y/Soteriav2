import 'dart:async';
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

// --- Lobby ---

class VersusLobbyState {
  final Category? category;
  final Difficulty difficulty;
  final int questionCount;
  final List<Category> categories;
  final bool isLoading;
  final String? error;

  const VersusLobbyState({
    this.category,
    this.difficulty = Difficulty.medium,
    this.questionCount = 10,
    this.categories = const [],
    this.isLoading = false,
    this.error,
  });

  VersusLobbyState copyWith({
    Category? category,
    Difficulty? difficulty,
    int? questionCount,
    List<Category>? categories,
    bool? isLoading,
    String? error,
  }) {
    return VersusLobbyState(
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      questionCount: questionCount ?? this.questionCount,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class VersusLobbyNotifier extends Notifier<VersusLobbyState> {
  @override
  VersusLobbyState build() {
    _init();
    return const VersusLobbyState();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    try {
      final categories = await ref.read(categoryRepositoryProvider).getCategories();
      state = state.copyWith(
        isLoading: false,
        categories: categories,
        category: categories.isNotEmpty ? categories.first : null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateCategory(Category category) => state = state.copyWith(category: category);
  void updateDifficulty(Difficulty diff) => state = state.copyWith(difficulty: diff);
  void updateQuestionCount(int count) => state = state.copyWith(questionCount: count);
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
