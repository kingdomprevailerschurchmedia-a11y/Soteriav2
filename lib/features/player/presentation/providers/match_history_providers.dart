import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/competitive_match.dart';
import '../../domain/models/competitive_result.dart';
import '../../domain/usecases/fetch_match_history_use_case.dart';
import '../../domain/models/competitive_statistics.dart';
import '../../domain/services/competitive_statistics_service.dart';
import '../../domain/repositories/match_history_repository.dart';
import '../../data/repositories/firebase_match_history_repository.dart';
import 'progression_providers.dart';
import 'rank_providers.dart';
import 'statistics_providers.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../quiz/data/repository/quiz_repository_provider.dart';

class MatchHistoryFilters {
  final String? seasonId;
  final String? mode;
  final CompetitiveOutcome? outcome;

  const MatchHistoryFilters({this.seasonId, this.mode, this.outcome});

  MatchHistoryFilters copyWith({
    String? seasonId,
    String? mode,
    CompetitiveOutcome? outcome,
    bool clearSeason = false,
    bool clearMode = false,
    bool clearOutcome = false,
  }) {
    return MatchHistoryFilters(
      seasonId: clearSeason ? null : (seasonId ?? this.seasonId),
      mode: clearMode ? null : (mode ?? this.mode),
      outcome: clearOutcome ? null : (outcome ?? this.outcome),
    );
  }
}

final matchHistoryFiltersProvider = StateProvider<MatchHistoryFilters>(
  (ref) => const MatchHistoryFilters(),
);

final matchHistoryRepositoryProvider = Provider<MatchHistoryRepository>((ref) {
  return FirebaseMatchHistoryRepository(
    resultRepository: ref.watch(competitiveResultRepositoryProvider),
    rankRepository: ref.watch(rankHistoryRepositoryProvider),
    quizRepository: ref.watch(quizHistoryRepositoryProvider),
  );
});

final fetchMatchHistoryUseCaseProvider = Provider<FetchMatchHistoryUseCase>((
  ref,
) {
  return FetchMatchHistoryUseCase(ref.watch(matchHistoryRepositoryProvider));
});

class MatchHistoryNotifier
    extends StateNotifier<AsyncValue<List<CompetitiveMatch>>> {
  final FetchMatchHistoryUseCase _useCase;
  final String _userId;
  final MatchHistoryFilters _filters;
  bool _hasMore = true;
  CompetitiveMatch? _lastMatch;

  MatchHistoryNotifier(this._useCase, this._userId, this._filters)
    : super(const AsyncValue.loading()) {
    loadInitial();
  }

  Future<void> loadInitial() async {
    state = const AsyncValue.loading();
    try {
      final matches = await _useCase.execute(
        _userId,
        limit: 20,
        seasonId: _filters.seasonId,
        mode: _filters.mode,
        outcome: _filters.outcome,
      );
      _hasMore = matches.length == 20;
      if (matches.isNotEmpty) {
        _lastMatch = matches.last;
      }
      state = AsyncValue.data(matches);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading || state.isRefreshing) return;

    final currentMatches = state.value ?? [];
    try {
      final newMatches = await _useCase.execute(
        _userId,
        limit: 20,
        lastMatch: _lastMatch,
        seasonId: _filters.seasonId,
        mode: _filters.mode,
        outcome: _filters.outcome,
      );

      _hasMore = newMatches.length == 20;
      if (newMatches.isNotEmpty) {
        _lastMatch = newMatches.last;
      }

      state = AsyncValue.data([...currentMatches, ...newMatches]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  bool get hasMore => _hasMore;
}

final matchHistoryProvider =
    StateNotifierProvider.family<
      MatchHistoryNotifier,
      AsyncValue<List<CompetitiveMatch>>,
      String
    >((ref, userId) {
      final filters = ref.watch(matchHistoryFiltersProvider);
      return MatchHistoryNotifier(
        ref.watch(fetchMatchHistoryUseCaseProvider),
        userId,
        filters,
      );
    });

final currentUserMatchHistoryProvider =
    Provider<AsyncValue<List<CompetitiveMatch>>>((ref) {
      final userId = ref.watch(authRepositoryProvider).currentUserId;
      if (userId == null) return const AsyncValue.data([]);
      return ref.watch(matchHistoryProvider(userId));
    });

final matchHistoryInsightsProvider =
    Provider<AsyncValue<List<PerformanceInsight>>>((ref) {
      final matchesAsync = ref.watch(currentUserMatchHistoryProvider);
      final service = ref.watch(statisticsServiceProvider);

      return matchesAsync.whenData(
        (matches) => service.generateMatchInsights(matches),
      );
    });
