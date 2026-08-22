import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/competitive_statistics.dart';
import 'competitive_profile_provider.dart';
import 'service_providers.dart';

final Provider<AsyncValue<CompetitiveStatistics>>
competitiveStatisticsProvider = Provider<AsyncValue<CompetitiveStatistics>>((
  ref,
) {
  final profileAsync = ref.watch(competitiveProfileProvider);
  final service = ref.watch(statisticsServiceProvider);

  return profileAsync.when(
    data: (profile) {
      final stats = service.calculate(
        userId: profile.identity.uid,
        profile: profile.identity,
        history: profile.history,
        progression: profile.progression,
        currentSeason: profile.currentSeason,
        globalPosition: profile.globalPosition,
      );
      return AsyncValue.data(stats);
    },
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
});

final careerStatisticsProvider = Provider<AsyncValue<CareerStatistics>>((ref) {
  return ref.watch(competitiveStatisticsProvider).whenData((s) => s.career);
});

final currentSeasonStatisticsProvider = Provider<AsyncValue<SeasonStatistics?>>(
  (ref) {
    return ref
        .watch(competitiveStatisticsProvider)
        .whenData((s) => s.currentSeason);
  },
);

final performanceTrendsProvider = Provider<AsyncValue<List<PerformanceTrend>>>((
  ref,
) {
  return ref.watch(competitiveStatisticsProvider).whenData((s) => s.trends);
});

final performanceInsightsProvider =
    Provider<AsyncValue<List<PerformanceInsight>>>((ref) {
      return ref
          .watch(competitiveStatisticsProvider)
          .whenData((s) => s.insights);
    });
