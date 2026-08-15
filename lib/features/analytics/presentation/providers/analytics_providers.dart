import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/features/analytics/domain/models/analytics_enums.dart';
import 'package:soteria/features/analytics/domain/models/performance_analytics.dart';
import 'package:soteria/features/analytics/domain/repositories/performance_analytics_repository.dart';
import 'package:soteria/features/analytics/data/repositories/performance_analytics_repository_impl.dart';
import 'package:soteria/features/analytics/domain/repositories/question_analytics_repository.dart';
import 'package:soteria/features/analytics/data/repositories/firestore_question_analytics_repository.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart'
    as quiz_enums;
import 'package:soteria/features/quiz/data/repository/quiz_repository_provider.dart';

final performanceAnalyticsRepositoryProvider =
    Provider<PerformanceAnalyticsRepository>((ref) {
      final historyRepo = ref.watch(quizHistoryRepositoryProvider);
      return PerformanceAnalyticsRepositoryImpl(historyRepo);
    });

final questionAnalyticsRepositoryProvider =
    Provider<QuestionAnalyticsRepository>((ref) {
      final database = ref.watch(firestoreDatabaseServiceProvider);
      return FirestoreQuestionAnalyticsRepository(database);
    });

final selectedTimePeriodProvider = StateProvider<TimePeriod>(
  (ref) => TimePeriod.last30Days,
);
final selectedAnalyticsCategoryProvider = StateProvider<String?>((ref) => null);
final selectedAnalyticsModeProvider = StateProvider<quiz_enums.GameMode?>(
  (ref) => null,
);

final personalPerformanceAnalyticsProvider =
    FutureProvider<PersonalPerformanceAnalytics>((ref) async {
      final playerId = ref.watch(sessionProvider).uid;
      if (playerId == null) {
        throw Exception('User not logged in');
      }

      final period = ref.watch(selectedTimePeriodProvider);
      final category = ref.watch(selectedAnalyticsCategoryProvider);
      final mode = ref.watch(selectedAnalyticsModeProvider);

      final repository = ref.watch(performanceAnalyticsRepositoryProvider);

      return repository.getAnalytics(
        playerId: playerId,
        period: period,
        category: category,
        mode: mode,
      );
    });

// Insights derived from analytics
final performanceInsightsProvider = Provider<List>((ref) {
  final analyticsAsync = ref.watch(personalPerformanceAnalyticsProvider);
  return analyticsAsync.maybeWhen(
    data: (data) => data.insights,
    orElse: () => [],
  );
});

// Category stats
final topCategoriesProvider = Provider((ref) {
  final analyticsAsync = ref.watch(personalPerformanceAnalyticsProvider);
  return analyticsAsync.maybeWhen(
    data: (data) => data.categoryPerformance,
    orElse: () => [],
  );
});
