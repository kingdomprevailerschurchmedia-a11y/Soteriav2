import '../models/analytics_enums.dart';
import '../models/performance_analytics.dart';
import '../../../quiz/domain/models/quiz_enums.dart';

abstract class PerformanceAnalyticsRepository {
  Future<PersonalPerformanceAnalytics> getAnalytics({
    required String playerId,
    required TimePeriod period,
    required PerformanceMode performanceMode,
    String? category,
    GameMode? gameMode,
  });

  Future<void> clearCache();
}
