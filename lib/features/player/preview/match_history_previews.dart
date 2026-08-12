import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_match.dart';
import '../domain/models/competitive_result.dart';
import '../domain/repositories/match_history_repository.dart';
import '../domain/usecases/fetch_match_history_use_case.dart';
import '../presentation/providers/match_history_providers.dart';
import '../presentation/providers/statistics_providers.dart';
import '../presentation/screens/competitive_match_history_screen.dart';
import '../domain/models/competitive_statistics.dart';
import 'match_history_fixtures.dart';

class MatchHistoryPreviewWrapper extends StatelessWidget {
  final List<CompetitiveMatch> matches;
  final bool isLoading;
  final bool hasError;

  const MatchHistoryPreviewWrapper({
    super.key,
    required this.matches,
    this.isLoading = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        matchHistoryProvider('user_1').overrideWith(
          (ref) => MockMatchHistoryNotifier(matches, isLoading, hasError),
        ),
        competitiveStatisticsProvider.overrideWith(
          (ref) => AsyncValue.data(
            CompetitiveStatistics(
              userId: 'user_1',
              career: const CareerStatistics(
                gamesPlayed: 25,
                gamesWon: 16,
                gamesLost: 9,
                winRate: 0.64,
                totalQuestionsAnswered: 500,
                correctAnswers: 420,
                accuracy: 0.84,
                currentStreak: 5,
                highestStreak: 12,
                bestRank: 'Gold I',
                peakPosition: 150,
                seasonsPlayed: 3,
              ),
              currentSeason: null,
              trends: [
                const PerformanceTrend(
                  state: TrendState.improving,
                  changePercentage: 0.12,
                  metricName: 'Win Rate',
                  dataPoints: [0.5, 0.55, 0.52, 0.58, 0.64],
                ),
                const PerformanceTrend(
                  state: TrendState.stable,
                  changePercentage: 0.02,
                  metricName: 'Accuracy',
                  dataPoints: [0.8, 0.82, 0.81, 0.83, 0.84],
                ),
              ],
              insights: [],
            ),
          ),
        ),
      ],
      child: const CompetitiveMatchHistoryScreen(),
    );
  }
}

class MockMatchHistoryNotifier extends MatchHistoryNotifier {
  final List<CompetitiveMatch> _matches;
  final bool _isLoading;
  final bool _hasError;

  MockMatchHistoryNotifier(this._matches, this._isLoading, this._hasError)
    : super(
        FetchMatchHistoryUseCase(FakeMatchHistoryRepository()),
        'user_1',
        const MatchHistoryFilters(),
      );

  @override
  AsyncValue<List<CompetitiveMatch>> get state {
    if (_isLoading) return const AsyncValue.loading();
    if (_hasError)
      return AsyncValue.error(
        'Failed to load match history',
        StackTrace.current,
      );
    return AsyncValue.data(_matches);
  }

  @override
  Future<void> loadInitial() async {}

  @override
  Future<void> loadMore() async {}

  @override
  bool get hasMore => false;
}

class FakeMatchHistoryRepository implements MatchHistoryRepository {
  @override
  Future<List<CompetitiveMatch>> getMatchHistory(
    String userId, {
    int limit = 20,
    CompetitiveMatch? lastMatch,
    String? seasonId,
    String? mode,
    CompetitiveOutcome? outcome,
  }) async => [];
  @override
  Future<CompetitiveMatch?> getMatchDetail(
    String userId,
    String resultId,
  ) async => null;
}

class MatchHistoryPreviews {
  static Widget full() =>
      MatchHistoryPreviewWrapper(matches: MatchHistoryFixtures.list());
  static Widget empty() => const MatchHistoryPreviewWrapper(matches: []);
  static Widget loading() =>
      const MatchHistoryPreviewWrapper(matches: [], isLoading: true);
  static Widget error() =>
      const MatchHistoryPreviewWrapper(matches: [], hasError: true);
}
