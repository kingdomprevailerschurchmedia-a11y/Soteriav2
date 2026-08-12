import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_statistics.dart';
import '../presentation/providers/statistics_providers.dart';
import '../presentation/screens/competitive_statistics_screen.dart';

class StatisticsPreviewWrapper extends StatelessWidget {
  final CompetitiveStatistics? stats;
  final bool isLoading;
  final Object? error;

  const StatisticsPreviewWrapper({
    super.key,
    this.stats,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        competitiveStatisticsProvider.overrideWithValue(
          isLoading
              ? const AsyncValue.loading()
              : error != null
              ? AsyncValue.error(error!, StackTrace.current)
              : AsyncValue.data(stats!),
        ),
      ],
      child: const CompetitiveStatisticsScreen(),
    );
  }
}

class StatisticsPreviews {
  static CareerStatistics mockCareer() {
    return const CareerStatistics(
      gamesPlayed: 1284,
      gamesWon: 872,
      gamesLost: 412,
      winRate: 0.679,
      totalQuestionsAnswered: 15420,
      correctAnswers: 10485,
      accuracy: 0.68,
      currentStreak: 3,
      highestStreak: 12,
      bestRank: 'Diamond II',
      peakPosition: 42,
      seasonsPlayed: 12,
    );
  }

  static CompetitiveStatistics fullStats() {
    return CompetitiveStatistics(
      userId: 'u1',
      career: mockCareer(),
      currentSeason: const SeasonStatistics(
        seasonId: 's8',
        seasonName: 'Season 8',
        gamesPlayed: 142,
        gamesWon: 97,
        gamesLost: 45,
        winRate: 0.683,
        totalPoints: 2840,
        averagePoints: 842,
        bestScore: 1240,
        accuracy: 0.71,
        currentPosition: 127,
      ),
      trends: [
        const PerformanceTrend(
          state: TrendState.improving,
          changePercentage: 0.07,
          metricName: 'Win Rate',
          dataPoints: [0.55, 0.58, 0.61, 0.64, 0.68],
        ),
        const PerformanceTrend(
          state: TrendState.stable,
          changePercentage: 0.01,
          metricName: 'Accuracy',
          dataPoints: [0.65, 0.66, 0.67, 0.66, 0.68],
        ),
      ],
      insights: [
        const PerformanceInsight(
          title: 'Win rate improved',
          description: 'Your win rate increased by 7% compared to last season.',
          isPositive: true,
        ),
        const PerformanceInsight(
          title: 'Consistent Performer',
          description:
              'You have maintained a win rate above 60% for 3 consecutive seasons.',
          isPositive: true,
        ),
      ],
      recentForm: ['W', 'W', 'W', 'L', 'W', 'W', 'L', 'W'],
    );
  }

  static CompetitiveStatistics emptyStats() {
    return const CompetitiveStatistics(
      userId: 'u1',
      career: CareerStatistics(
        gamesPlayed: 0,
        gamesWon: 0,
        gamesLost: 0,
        winRate: 0.0,
        totalQuestionsAnswered: 0,
        correctAnswers: 0,
        accuracy: 0.0,
        currentStreak: 0,
        highestStreak: 0,
        bestRank: 'Unranked',
        peakPosition: -1,
        seasonsPlayed: 0,
      ),
      currentSeason: null,
      trends: [],
      insights: [],
      recentForm: [],
    );
  }

  static Widget standard() => StatisticsPreviewWrapper(stats: fullStats());

  static Widget improving() {
    final stats = fullStats();
    return StatisticsPreviewWrapper(
      stats: stats.copyWith(
        trends: [
          const PerformanceTrend(
            state: TrendState.improving,
            changePercentage: 0.12,
            metricName: 'Win Rate',
            dataPoints: [0.45, 0.48, 0.52, 0.58, 0.68],
          ),
        ],
      ),
    );
  }

  static Widget declining() {
    final stats = fullStats();
    return StatisticsPreviewWrapper(
      stats: stats.copyWith(
        trends: [
          const PerformanceTrend(
            state: TrendState.declining,
            changePercentage: -0.08,
            metricName: 'Accuracy',
            dataPoints: [0.75, 0.72, 0.70, 0.68, 0.65],
          ),
        ],
      ),
    );
  }

  static Widget empty() => StatisticsPreviewWrapper(stats: emptyStats());

  static Widget loading() => const StatisticsPreviewWrapper(isLoading: true);

  static Widget error() =>
      const StatisticsPreviewWrapper(error: 'Data Sync Failed');
}
