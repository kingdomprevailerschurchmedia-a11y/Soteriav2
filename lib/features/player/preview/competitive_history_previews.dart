import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/season_result.dart';
import '../presentation/providers/history_providers.dart';
import '../presentation/screens/competitive_history_screen.dart';

class CompetitiveHistoryPreviewWrapper extends StatelessWidget {
  final List<SeasonResult> results;
  final SeasonResult? latest;
  final SeasonResult? best;

  const CompetitiveHistoryPreviewWrapper({
    super.key,
    required this.results,
    this.latest,
    this.best,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        seasonHistoryProvider.overrideWith((ref) => Stream.value(results)),
        latestSeasonResultProvider.overrideWith((ref) => Future.value(latest)),
        bestSeasonResultProvider.overrideWith((ref) => Future.value(best)),
      ],
      child: const CompetitiveHistoryScreen(),
    );
  }
}

class CompetitiveHistoryPreviews {
  static List<SeasonResult> mockResults() {
    final now = DateTime.now();
    return [
      SeasonResult(
        seasonId: 's5',
        userId: 'u1',
        seasonName: 'Ascension',
        seasonNumber: 5,
        finalPosition: 127,
        finalRankPoints: 2840,
        finalTier: 'Diamond',
        finalDivision: 2,
        previousTier: 'Platinum',
        previousDivision: 1,
        rankChange: 450,
        completedAt: now.subtract(const Duration(days: 2)),
        createdAt: now.subtract(const Duration(days: 32)),
        updatedAt: now.subtract(const Duration(days: 2)),
      ),
      SeasonResult(
        seasonId: 's4',
        userId: 'u1',
        seasonName: 'Origins',
        seasonNumber: 4,
        finalPosition: 542,
        finalRankPoints: 2100,
        finalTier: 'Platinum',
        finalDivision: 3,
        previousTier: 'Gold',
        previousDivision: 1,
        rankChange: 600,
        completedAt: now.subtract(const Duration(days: 92)),
        createdAt: now.subtract(const Duration(days: 122)),
        updatedAt: now.subtract(const Duration(days: 92)),
      ),
      SeasonResult(
        seasonId: 's3',
        userId: 'u1',
        seasonName: 'Pioneers',
        seasonNumber: 3,
        finalPosition: 1200,
        finalRankPoints: 1500,
        finalTier: 'Gold',
        finalDivision: 1,
        previousTier: 'Silver',
        previousDivision: 2,
        rankChange: 300,
        completedAt: now.subtract(const Duration(days: 182)),
        createdAt: now.subtract(const Duration(days: 212)),
        updatedAt: now.subtract(const Duration(days: 182)),
      ),
    ];
  }

  static Widget fullHistory() {
    final results = mockResults();
    return CompetitiveHistoryPreviewWrapper(
      results: results,
      latest: results[0],
      best: results[0],
    );
  }

  static Widget empty() => const CompetitiveHistoryPreviewWrapper(results: []);

  static Widget unranked() {
    final now = DateTime.now();
    final result = SeasonResult(
      seasonId: 's1',
      userId: 'u1',
      seasonName: 'Beta',
      seasonNumber: 1,
      finalPosition: 0,
      finalRankPoints: 0,
      finalTier: 'Unranked',
      finalDivision: 0,
      previousTier: 'Unranked',
      previousDivision: 0,
      rankChange: 0,
      completedAt: now.subtract(const Duration(days: 365)),
      createdAt: now.subtract(const Duration(days: 400)),
      updatedAt: now.subtract(const Duration(days: 365)),
    );
    return CompetitiveHistoryPreviewWrapper(
      results: [result],
      latest: result,
      best: result,
    );
  }

  static Widget loading() {
    return ProviderScope(
      overrides: [
        competitiveHistorySummaryProvider.overrideWithValue(
          const AsyncValue.loading(),
        ),
      ],
      child: const CompetitiveHistoryScreen(),
    );
  }

  static Widget error() {
    return ProviderScope(
      overrides: [
        competitiveHistorySummaryProvider.overrideWithValue(
          AsyncValue.error('Failed to load history', StackTrace.current),
        ),
      ],
      child: const CompetitiveHistoryScreen(),
    );
  }

  static Widget reducedMotion() {
    final results = mockResults();
    return MediaQuery(
      data: const MediaQueryData(disableAnimations: true),
      child: CompetitiveHistoryPreviewWrapper(
        results: results,
        latest: results[0],
        best: results[0],
      ),
    );
  }
}
