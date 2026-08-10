import '../domain/models/analytics_enums.dart';
import '../domain/models/performance_analytics.dart';
import '../domain/models/performance_trend.dart';
import '../domain/models/category_performance.dart';
import '../domain/models/difficulty_performance.dart';
import '../domain/models/consistency_metrics.dart';
import '../domain/models/performance_insight.dart';
import '../../quiz/domain/models/quiz_enums.dart';

class AnalyticsMockData {
  static PersonalPerformanceAnalytics getBasicAnalytics() {
    final now = DateTime.now();
    return PersonalPerformanceAnalytics(
      playerId: 'player1',
      period: TimePeriod.last30Days,
      totalQuizzes: 12,
      totalQuestions: 120,
      totalCorrect: 96,
      totalIncorrect: 18,
      totalSkipped: 4,
      totalTimedOut: 2,
      averageAccuracy: 0.8,
      averageScore: 850,
      bestScore: 1200,
      bestAccuracy: 0.95,
      bestStreak: 12,
      averageResponseTime: const Duration(seconds: 4, milliseconds: 500),
      fastestResponseTime: const Duration(seconds: 1, milliseconds: 200),
      slowestResponseTime: const Duration(seconds: 12),
      totalXp: 4500,
      categoryPerformance: [
        CategoryPerformance(
          category: 'Science',
          totalQuizzes: 5,
          totalQuestions: 50,
          correctAnswers: 45,
          accuracy: 0.9,
          averageScore: 920,
          bestScore: 1100,
          averageResponseTime: const Duration(seconds: 3, milliseconds: 800),
          totalXp: 1800,
        ),
        CategoryPerformance(
          category: 'History',
          totalQuizzes: 4,
          totalQuestions: 40,
          correctAnswers: 30,
          accuracy: 0.75,
          averageScore: 780,
          bestScore: 950,
          averageResponseTime: const Duration(seconds: 5, milliseconds: 200),
          totalXp: 1400,
        ),
      ],
      difficultyPerformance: [
        DifficultyPerformance(
          difficulty: Difficulty.easy,
          totalQuizzes: 5,
          totalQuestions: 50,
          correctAnswers: 48,
          accuracy: 0.96,
          averageScore: 800,
          averageResponseTime: const Duration(seconds: 2, milliseconds: 500),
        ),
        DifficultyPerformance(
          difficulty: Difficulty.medium,
          totalQuizzes: 5,
          totalQuestions: 50,
          correctAnswers: 38,
          accuracy: 0.76,
          averageScore: 900,
          averageResponseTime: const Duration(seconds: 5),
        ),
        DifficultyPerformance(
          difficulty: Difficulty.hard,
          totalQuizzes: 2,
          totalQuestions: 20,
          correctAnswers: 10,
          accuracy: 0.5,
          averageScore: 1050,
          averageResponseTime: const Duration(seconds: 8),
        ),
      ],
      accuracyTrend: PerformanceTrend(
        label: 'Accuracy',
        points: List.generate(10, (i) => PerformanceTrendPoint(
          date: now.subtract(Duration(days: 10 - i)),
          value: 0.7 + (i * 0.02),
        )),
        averageValue: 0.8,
        minValue: 0.7,
        maxValue: 0.9,
        changeValue: 0.2,
        changePercentage: 28.5,
      ),
      scoreTrend: PerformanceTrend(
        label: 'Score',
        points: List.generate(10, (i) => PerformanceTrendPoint(
          date: now.subtract(Duration(days: 10 - i)),
          value: 700.0 + (i * 30),
        )),
        averageValue: 850,
        minValue: 700,
        maxValue: 1000,
        changeValue: 300,
        changePercentage: 42.8,
      ),
      speedTrend: PerformanceTrend(
        label: 'Speed',
        points: List.generate(10, (i) => PerformanceTrendPoint(
          date: now.subtract(Duration(days: 10 - i)),
          value: 6000.0 - (i * 200),
        )),
        averageValue: 5000,
        minValue: 4000,
        maxValue: 6000,
        changeValue: -2000,
        changePercentage: -33.3,
      ),
      xpTrend: PerformanceTrend(
        label: 'XP',
        points: List.generate(10, (i) => PerformanceTrendPoint(
          date: now.subtract(Duration(days: 10 - i)),
          value: 300.0 + (i * 50),
        )),
        averageValue: 550,
        minValue: 300,
        maxValue: 800,
        changeValue: 500,
        changePercentage: 166.6,
      ),
      consistency: const ConsistencyMetrics(
        accuracyVariance: 0.02,
        scoreVariance: 5000,
        consistencyScore: 0.82,
        consistencyLevel: 'Consistent',
        streakStability: 8,
      ),
      insights: [
        PerformanceInsight(
          type: InsightType.improvement,
          title: 'Accuracy Improving',
          description: 'Your accuracy increased by 9 percentage points over your last 10 quizzes.',
          metricLabel: 'Change',
          metricValue: '+9%',
          direction: TrendDirection.improving,
          confidence: InsightConfidence.high,
          generatedAt: now,
          recommendation: 'Keep practicing at this level.',
        ),
        PerformanceInsight(
          type: InsightType.strength,
          title: 'Science Master',
          description: 'Science is your best-performing category with 92% accuracy.',
          metricLabel: 'Accuracy',
          metricValue: '92%',
          direction: TrendDirection.improving,
          confidence: InsightConfidence.high,
          generatedAt: now,
          recommendation: 'Try higher difficulty in this category.',
        ),
      ],
      calculatedAt: now,
    );
  }

  static PersonalPerformanceAnalytics getNoDataAnalytics() {
    return PersonalPerformanceAnalytics(
      playerId: 'player1',
      period: TimePeriod.last30Days,
      totalQuizzes: 0,
      totalQuestions: 0,
      totalCorrect: 0,
      totalIncorrect: 0,
      totalSkipped: 0,
      totalTimedOut: 0,
      averageAccuracy: 0,
      averageScore: 0,
      bestScore: 0,
      bestAccuracy: 0,
      bestStreak: 0,
      averageResponseTime: Duration.zero,
      fastestResponseTime: Duration.zero,
      slowestResponseTime: Duration.zero,
      totalXp: 0,
      categoryPerformance: [],
      difficultyPerformance: [],
      accuracyTrend: _emptyTrend('Accuracy'),
      scoreTrend: _emptyTrend('Score'),
      speedTrend: _emptyTrend('Speed'),
      xpTrend: _emptyTrend('XP'),
      consistency: const ConsistencyMetrics(
        accuracyVariance: 0,
        scoreVariance: 0,
        consistencyScore: 0,
        consistencyLevel: 'No Data',
        streakStability: 0,
      ),
      insights: [
        PerformanceInsight(
          type: InsightType.insufficientData,
          title: 'Your performance story starts here',
          description: 'Complete a few more quizzes to unlock detailed insights.',
          metricLabel: 'Status',
          metricValue: 'No Data',
          direction: TrendDirection.insufficientData,
          confidence: InsightConfidence.insufficientData,
          generatedAt: DateTime.now(),
        )
      ],
      calculatedAt: DateTime.now(),
    );
  }

  static PerformanceTrend _emptyTrend(String label) => PerformanceTrend(
    label: label,
    points: [],
    averageValue: 0,
    minValue: 0,
    maxValue: 0,
    changeValue: 0,
    changePercentage: 0,
  );
}
