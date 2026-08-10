import '../../domain/models/analytics_enums.dart';
import '../../domain/models/performance_analytics.dart';
import '../../domain/repositories/performance_analytics_repository.dart';
import '../../../quiz/domain/repositories/quiz_history_repository.dart';
import '../../../quiz/domain/models/quiz_enums.dart';
import '../../../quiz/domain/models/quiz_result.dart';
import 'analytics_aggregator.dart';

class PerformanceAnalyticsRepositoryImpl
    implements PerformanceAnalyticsRepository {
  final QuizHistoryRepository _historyRepository;

  // Simple in-memory cache
  final Map<String, PersonalPerformanceAnalytics> _cache = {};

  PerformanceAnalyticsRepositoryImpl(this._historyRepository);

  @override
  Future<PersonalPerformanceAnalytics> getAnalytics({
    required String playerId,
    required TimePeriod period,
    String? category,
    GameMode? mode,
  }) async {
    final cacheKey = _getCacheKey(playerId, period, category, mode);
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    final now = DateTime.now();
    final start = _getStartDate(period, now);

    // Get current period results
    List<QuizResult> currentResults = await _historyRepository
        .getResultsByDateRange(playerId, start, now);

    // Apply filters
    if (category != null) {
      currentResults = currentResults
          .where((r) => r.category == category)
          .toList();
    }
    if (mode != null) {
      currentResults = currentResults.where((r) => r.gameMode == mode).toList();
    }

    // Get previous period results for comparison
    final prevStart = _getPreviousPeriodStart(period, start);
    List<QuizResult> previousResults = await _historyRepository
        .getResultsByDateRange(playerId, prevStart, start);

    if (category != null) {
      previousResults = previousResults
          .where((r) => r.category == category)
          .toList();
    }
    if (mode != null) {
      previousResults = previousResults
          .where((r) => r.gameMode == mode)
          .toList();
    }

    final analytics = AnalyticsAggregator.aggregate(
      playerId: playerId,
      period: period,
      currentResults: currentResults,
      previousResults: previousResults,
    );

    _cache[cacheKey] = analytics;
    return analytics;
  }

  @override
  Future<void> clearCache() async {
    _cache.clear();
  }

  String _getCacheKey(
    String playerId,
    TimePeriod period,
    String? category,
    GameMode? mode,
  ) {
    return '$playerId-$period-${category ?? "all"}-${mode ?? "all"}';
  }

  DateTime _getStartDate(TimePeriod period, DateTime now) {
    switch (period) {
      case TimePeriod.last7Days:
        return now.subtract(const Duration(days: 7));
      case TimePeriod.last30Days:
        return now.subtract(const Duration(days: 30));
      case TimePeriod.last90Days:
        return now.subtract(const Duration(days: 90));
      case TimePeriod.allTime:
        return DateTime(2000); // Far past
    }
  }

  DateTime _getPreviousPeriodStart(TimePeriod period, DateTime currentStart) {
    switch (period) {
      case TimePeriod.last7Days:
        return currentStart.subtract(const Duration(days: 7));
      case TimePeriod.last30Days:
        return currentStart.subtract(const Duration(days: 30));
      case TimePeriod.last90Days:
        return currentStart.subtract(const Duration(days: 90));
      case TimePeriod.allTime:
        return currentStart; // No comparison for all time
    }
  }
}
