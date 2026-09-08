import '../../domain/models/analytics_enums.dart';
import '../../domain/models/performance_analytics.dart';
import '../../domain/repositories/performance_analytics_repository.dart';
import '../../../quiz/domain/repositories/quiz_history_repository.dart';
import '../../../practice/domain/repositories/practice_result_repository.dart';
import '../../../quiz/domain/models/quiz_enums.dart';
import '../../../quiz/domain/models/quiz_result.dart';
import 'analytics_aggregator.dart';

class PerformanceAnalyticsRepositoryImpl
    implements PerformanceAnalyticsRepository {
  final QuizHistoryRepository _historyRepository;
  final PracticeResultRepository _practiceRepository;

  // Simple in-memory cache
  final Map<String, PersonalPerformanceAnalytics> _cache = {};

  PerformanceAnalyticsRepositoryImpl(
    this._historyRepository,
    this._practiceRepository,
  );

  @override
  Future<PersonalPerformanceAnalytics> getAnalytics({
    required String playerId,
    required TimePeriod period,
    required PerformanceMode performanceMode,
    String? category,
    GameMode? gameMode,
  }) async {
    final cacheKey = _getCacheKey(playerId, period, performanceMode, category, gameMode);
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    final now = DateTime.now();
    final start = _getStartDate(period, now);

    // Get current period results
    final quizResults = await _historyRepository.getResultsByDateRange(
      playerId,
      start,
      now,
    );
    final practiceResults = await _practiceRepository.getResultsByDateRange(
      playerId,
      start,
      now,
    );

    List<QuizResult> currentResults = [
      ...quizResults,
      ...practiceResults.map(AnalyticsAggregator.mapPracticeToQuiz),
    ];

    // Apply Performance Mode Filters
    if (performanceMode == PerformanceMode.practice) {
      currentResults = currentResults.where((r) => r.gameMode == GameMode.practice).toList();
    } else if (performanceMode == PerformanceMode.competitive) {
      currentResults = currentResults.where((r) => 
        r.gameMode == GameMode.pro || 
        r.gameMode == GameMode.tournament || 
        r.gameMode == GameMode.versus
      ).toList();
    }

    // Apply specific filters
    if (category != null) {
      currentResults =
          currentResults.where((r) => r.category == category).toList();
    }
    if (gameMode != null) {
      currentResults = currentResults.where((r) => r.gameMode == gameMode).toList();
    }

    // Get previous period results for comparison
    final prevStart = _getPreviousPeriodStart(period, start);
    final prevQuizResults = await _historyRepository.getResultsByDateRange(
      playerId,
      prevStart,
      start,
    );
    final prevPracticeResults = await _practiceRepository.getResultsByDateRange(
      playerId,
      prevStart,
      start,
    );

    List<QuizResult> previousResults = [
      ...prevQuizResults,
      ...prevPracticeResults.map(AnalyticsAggregator.mapPracticeToQuiz),
    ];

    if (performanceMode == PerformanceMode.practice) {
      previousResults = previousResults.where((r) => r.gameMode == GameMode.practice).toList();
    } else if (performanceMode == PerformanceMode.competitive) {
      previousResults = previousResults.where((r) => 
        r.gameMode == GameMode.pro || 
        r.gameMode == GameMode.tournament || 
        r.gameMode == GameMode.versus
      ).toList();
    }

    if (category != null) {
      previousResults =
          previousResults.where((r) => r.category == category).toList();
    }
    if (gameMode != null) {
      previousResults =
          previousResults.where((r) => r.gameMode == gameMode).toList();
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
    PerformanceMode performanceMode,
    String? category,
    GameMode? mode,
  ) {
    return '$playerId-$period-${performanceMode.toString().split('.').last}-${category ?? "all"}-${mode?.toString().split('.').last ?? "all"}';
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
