import 'dart:math';
import '../../../quiz/domain/models/quiz_result.dart';
import '../../../quiz/domain/models/quiz_enums.dart';
import '../../domain/models/analytics_enums.dart';
import '../../domain/models/performance_analytics.dart';
import '../../domain/models/category_performance.dart';
import '../../domain/models/difficulty_performance.dart';
import '../../domain/models/performance_trend.dart';
import '../../domain/models/consistency_metrics.dart';
import '../../domain/models/performance_insight.dart';

class AnalyticsAggregator {
  static PersonalPerformanceAnalytics aggregate({
    required String playerId,
    required TimePeriod period,
    required List<QuizResult> currentResults,
    required List<QuizResult> previousResults,
  }) {
    if (currentResults.isEmpty) {
      return _createEmptyAnalytics(playerId, period);
    }

    final totals = _calculateTotals(currentResults);
    final averages = _calculateAverages(currentResults, totals);
    final categoryPerf = _calculateCategoryPerformance(currentResults);
    final difficultyPerf = _calculateDifficultyPerformance(currentResults);
    final trends = _calculateTrends(currentResults, period);
    final consistency = _calculateConsistency(currentResults);
    
    // Insights & Recommendations
    final insights = _generateInsights(
      currentResults: currentResults,
      previousResults: previousResults,
      averages: averages,
      totals: totals,
      categoryPerf: categoryPerf,
      difficultyPerf: difficultyPerf,
      trends: trends,
      consistency: consistency,
    );

    return PersonalPerformanceAnalytics(
      playerId: playerId,
      period: period,
      totalQuizzes: currentResults.length,
      totalQuestions: totals.questions,
      totalCorrect: totals.correct,
      totalIncorrect: totals.incorrect,
      totalSkipped: totals.skipped,
      totalTimedOut: totals.timedOut,
      averageAccuracy: averages.accuracy,
      averageScore: averages.score,
      bestScore: totals.bestScore,
      bestAccuracy: totals.bestAccuracy,
      bestStreak: totals.bestStreak,
      averageResponseTime: averages.responseTime,
      fastestResponseTime: totals.fastestResponseTime,
      slowestResponseTime: totals.slowestResponseTime,
      totalXp: totals.xp,
      categoryPerformance: categoryPerf,
      difficultyPerformance: difficultyPerf,
      accuracyTrend: trends.accuracy,
      scoreTrend: trends.score,
      speedTrend: trends.speed,
      xpTrend: trends.xp,
      consistency: consistency,
      insights: insights,
      calculatedAt: DateTime.now(),
    );
  }

  static _Totals _calculateTotals(List<QuizResult> results) {
    int questions = 0;
    int correct = 0;
    int incorrect = 0;
    int skipped = 0;
    int timedOut = 0;
    int xp = 0;
    int bestScore = 0;
    double bestAccuracy = 0;
    int bestStreak = 0;
    Duration fastest = const Duration(hours: 1);
    Duration slowest = Duration.zero;

    for (final r in results) {
      questions += r.totalQuestions;
      correct += r.correctAnswers;
      incorrect += r.wrongAnswers;
      skipped += r.skipped;
      timedOut += r.timedOut;
      xp += r.xpEarned;
      if (r.finalScore > bestScore) bestScore = r.finalScore;
      if (r.accuracy > bestAccuracy) bestAccuracy = r.accuracy;
      if (r.longestStreak > bestStreak) bestStreak = r.longestStreak;
      if (r.averageResponseTime < fastest) fastest = r.averageResponseTime;
      if (r.averageResponseTime > slowest) slowest = r.averageResponseTime;
    }

    return _Totals(
      questions: questions,
      correct: correct,
      incorrect: incorrect,
      skipped: skipped,
      timedOut: timedOut,
      xp: xp,
      bestScore: bestScore,
      bestAccuracy: bestAccuracy,
      bestStreak: bestStreak,
      fastestResponseTime: fastest == const Duration(hours: 1) ? Duration.zero : fastest,
      slowestResponseTime: slowest,
    );
  }

  static _Averages _calculateAverages(List<QuizResult> results, _Totals totals) {
    if (results.isEmpty) return _Averages(accuracy: 0, score: 0, responseTime: Duration.zero);

    double totalAccuracy = 0;
    int totalScore = 0;
    int totalMillis = 0;

    for (final r in results) {
      totalAccuracy += r.accuracy;
      totalScore += r.finalScore;
      totalMillis += r.averageResponseTime.inMilliseconds;
    }

    return _Averages(
      accuracy: totalAccuracy / results.length,
      score: (totalScore / results.length).round(),
      responseTime: Duration(milliseconds: (totalMillis / results.length).round()),
    );
  }

  static List<CategoryPerformance> _calculateCategoryPerformance(List<QuizResult> results) {
    final Map<String, List<QuizResult>> grouped = {};
    for (final r in results) {
      grouped.putIfAbsent(r.category, () => []).add(r);
    }

    return grouped.entries.map((e) {
      final catResults = e.value;
      final catTotals = _calculateTotals(catResults);
      final catAverages = _calculateAverages(catResults, catTotals);

      return CategoryPerformance(
        category: e.key,
        totalQuizzes: catResults.length,
        totalQuestions: catTotals.questions,
        correctAnswers: catTotals.correct,
        accuracy: catAverages.accuracy,
        averageScore: catAverages.score,
        bestScore: catTotals.bestScore,
        averageResponseTime: catAverages.responseTime,
        totalXp: catTotals.xp,
      );
    }).toList()..sort((a, b) => b.accuracy.compareTo(a.accuracy));
  }

  static List<DifficultyPerformance> _calculateDifficultyPerformance(List<QuizResult> results) {
    final Map<Difficulty, List<QuizResult>> grouped = {};
    for (final r in results) {
      grouped.putIfAbsent(r.difficulty, () => []).add(r);
    }

    return Difficulty.values.map((d) {
      final diffResults = grouped[d] ?? [];
      if (diffResults.isEmpty) {
        return DifficultyPerformance(
          difficulty: d,
          totalQuizzes: 0,
          totalQuestions: 0,
          correctAnswers: 0,
          accuracy: 0,
          averageScore: 0,
          averageResponseTime: Duration.zero,
        );
      }
      final diffTotals = _calculateTotals(diffResults);
      final diffAverages = _calculateAverages(diffResults, diffTotals);

      return DifficultyPerformance(
        difficulty: d,
        totalQuizzes: diffResults.length,
        totalQuestions: diffTotals.questions,
        correctAnswers: diffTotals.correct,
        accuracy: diffAverages.accuracy,
        averageScore: diffAverages.score,
        averageResponseTime: diffAverages.responseTime,
      );
    }).toList();
  }

  static _Trends _calculateTrends(List<QuizResult> results, TimePeriod period) {
    // Sort by date ascending for trends
    final sorted = List<QuizResult>.from(results)..sort((a, b) => a.completedAt.compareTo(b.completedAt));

    final accuracyPoints = sorted.map((r) => PerformanceTrendPoint(date: r.completedAt, value: r.accuracy)).toList();
    final scorePoints = sorted.map((r) => PerformanceTrendPoint(date: r.completedAt, value: r.finalScore.toDouble())).toList();
    final speedPoints = sorted.map((r) => PerformanceTrendPoint(date: r.completedAt, value: r.averageResponseTime.inMilliseconds.toDouble())).toList();
    final xpPoints = sorted.map((r) => PerformanceTrendPoint(date: r.completedAt, value: r.xpEarned.toDouble())).toList();

    return _Trends(
      accuracy: _createTrend('Accuracy', accuracyPoints),
      score: _createTrend('Score', scorePoints),
      speed: _createTrend('Response Time', speedPoints),
      xp: _createTrend('XP', xpPoints),
    );
  }

  static PerformanceTrend _createTrend(String label, List<PerformanceTrendPoint> points) {
    if (points.isEmpty) {
      return PerformanceTrend(
        label: label,
        points: [],
        averageValue: 0,
        minValue: 0,
        maxValue: 0,
        changeValue: 0,
        changePercentage: 0,
      );
    }

    double sum = 0;
    double min = points[0].value;
    double max = points[0].value;
    for (final p in points) {
      sum += p.value;
      if (p.value < min) min = p.value;
      if (p.value > max) max = p.value;
    }

    final average = sum / points.length;
    final first = points.first.value;
    final last = points.last.value;
    final change = last - first;
    final changePct = first != 0 ? (change / first) * 100 : 0.0;

    return PerformanceTrend(
      label: label,
      points: points,
      averageValue: average,
      minValue: min,
      maxValue: max,
      changeValue: change,
      changePercentage: changePct,
    );
  }

  static ConsistencyMetrics _calculateConsistency(List<QuizResult> results) {
    if (results.length < 2) {
      return const ConsistencyMetrics(
        accuracyVariance: 0,
        scoreVariance: 0,
        consistencyScore: 0,
        consistencyLevel: 'Insufficient Data',
        streakStability: 0,
      );
    }

    final averages = _calculateAverages(results, _calculateTotals(results));
    
    double accuracyVarSum = 0;
    double scoreVarSum = 0;
    for (final r in results) {
      accuracyVarSum += pow(r.accuracy - averages.accuracy, 2);
      scoreVarSum += pow(r.finalScore - averages.score, 2);
    }

    final accuracyVar = accuracyVarSum / results.length;
    final scoreVar = scoreVarSum / results.length;

    // Consistency score normalized (heuristic)
    // Higher variance = lower consistency
    final accConsistency = max(0.0, 1.0 - (sqrt(accuracyVar) * 2));
    
    String level;
    if (accConsistency > 0.85) level = 'Highly Consistent';
    else if (accConsistency > 0.7) level = 'Consistent';
    else if (accConsistency > 0.5) level = 'Variable';
    else level = 'Highly Variable';

    return ConsistencyMetrics(
      accuracyVariance: accuracyVar,
      scoreVariance: scoreVar,
      consistencyScore: accConsistency,
      consistencyLevel: level,
      streakStability: 0, // Simplified for now
    );
  }

  static List<PerformanceInsight> _generateInsights({
    required List<QuizResult> currentResults,
    required List<QuizResult> previousResults,
    required _Averages averages,
    required _Totals totals,
    required List<CategoryPerformance> categoryPerf,
    required List<DifficultyPerformance> difficultyPerf,
    required _Trends trends,
    required ConsistencyMetrics consistency,
  }) {
    final List<PerformanceInsight> insights = [];

    if (currentResults.length < 3) {
      insights.add(PerformanceInsight(
        type: InsightType.insufficientData,
        title: 'Start Your Journey',
        description: 'Play ${3 - currentResults.length} more quizzes to unlock performance trends.',
        metricLabel: 'Quizzes Needed',
        metricValue: '${3 - currentResults.length}',
        direction: TrendDirection.insufficientData,
        confidence: InsightConfidence.insufficientData,
        generatedAt: DateTime.now(),
      ));
      return insights;
    }

    // 1. Accuracy Trend
    final accChange = trends.accuracy.changeValue;
    if (accChange.abs() > 0.05) {
      insights.add(PerformanceInsight(
        type: InsightType.accuracy,
        title: accChange > 0 ? 'Accuracy Improving' : 'Accuracy Declining',
        description: accChange > 0 
          ? 'Your accuracy increased by ${(accChange * 100).toStringAsFixed(1)} percentage points.' 
          : 'Your accuracy decreased by ${(accChange.abs() * 100).toStringAsFixed(1)} percentage points.',
        metricLabel: 'Change',
        metricValue: '${accChange > 0 ? '+' : ''}${(accChange * 100).toStringAsFixed(1)}%',
        direction: accChange > 0 ? TrendDirection.improving : TrendDirection.declining,
        confidence: InsightConfidence.medium,
        generatedAt: DateTime.now(),
        recommendation: accChange > 0 ? 'Keep it up!' : 'Focus on precision over speed.',
      ));
    }

    // 2. Speed/Accuracy Insight
    final speedChange = trends.speed.changeValue; // Negative is good (faster)
    if (speedChange < -500 && accChange > -0.02) {
      insights.add(PerformanceInsight(
        type: InsightType.speed,
        title: 'Efficiency Boost',
        description: 'You\'re answering faster while maintaining your accuracy.',
        metricLabel: 'Speed Gain',
        metricValue: '${(speedChange.abs() / 1000).toStringAsFixed(1)}s',
        direction: TrendDirection.improving,
        confidence: InsightConfidence.high,
        generatedAt: DateTime.now(),
        recommendation: 'You\'re performing efficiently.',
      ));
    } else if (speedChange < -500 && accChange < -0.05) {
      insights.add(PerformanceInsight(
        type: InsightType.speed,
        title: 'Speed vs Accuracy',
        description: 'Your speed has improved, but accuracy has dropped.',
        metricLabel: 'Accuracy Loss',
        metricValue: '${(accChange.abs() * 100).toStringAsFixed(1)}%',
        direction: TrendDirection.declining,
        confidence: InsightConfidence.high,
        generatedAt: DateTime.now(),
        recommendation: 'Consider slowing down slightly.',
      ));
    }

    // 3. Category Strength/Weakness
    if (categoryPerf.isNotEmpty) {
      final strongest = categoryPerf.first;
      final weakest = categoryPerf.last;

      if (strongest.totalQuizzes >= 3) {
        insights.add(PerformanceInsight(
          type: InsightType.strength,
          title: 'Strongest Category',
          description: '${strongest.category} is your best-performing subject.',
          metricLabel: 'Accuracy',
          metricValue: '${(strongest.accuracy * 100).toStringAsFixed(1)}%',
          direction: TrendDirection.improving,
          confidence: InsightConfidence.medium,
          generatedAt: DateTime.now(),
          recommendation: 'Try higher difficulty in this category.',
        ));
      }

      if (weakest.totalQuizzes >= 3 && weakest != strongest) {
        insights.add(PerformanceInsight(
          type: InsightType.opportunity,
          title: 'Growth Opportunity',
          description: '${weakest.category} is currently your biggest opportunity for improvement.',
          metricLabel: 'Accuracy',
          metricValue: '${(weakest.accuracy * 100).toStringAsFixed(1)}%',
          direction: TrendDirection.stable,
          confidence: InsightConfidence.medium,
          generatedAt: DateTime.now(),
          recommendation: 'Practice more quizzes in this subject.',
        ));
      }
    }

    // 4. Difficulty Insight
    final hardPerf = difficultyPerf.firstWhere((d) => d.difficulty == Difficulty.hard, orElse: () => difficultyPerf.first);
    if (hardPerf.totalQuizzes >= 3 && hardPerf.accuracy < 0.6) {
      insights.add(PerformanceInsight(
        type: InsightType.difficulty,
        title: 'Hard Challenge',
        description: 'Hard questions are currently your biggest challenge.',
        metricLabel: 'Accuracy',
        metricValue: '${(hardPerf.accuracy * 100).toStringAsFixed(1)}%',
        direction: TrendDirection.stable,
        confidence: InsightConfidence.high,
        generatedAt: DateTime.now(),
        recommendation: 'Practice more Hard questions.',
      ));
    }

    return insights;
  }

  static PersonalPerformanceAnalytics _createEmptyAnalytics(String playerId, TimePeriod period) {
    return PersonalPerformanceAnalytics(
      playerId: playerId,
      period: period,
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
      accuracyTrend: _createTrend('Accuracy', []),
      scoreTrend: _createTrend('Score', []),
      speedTrend: _createTrend('Speed', []),
      xpTrend: _createTrend('XP', []),
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
          title: 'Welcome to Soteria',
          description: 'Your performance story starts here. Complete a few more quizzes to unlock detailed insights.',
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
}

class _Totals {
  final int questions;
  final int correct;
  final int incorrect;
  final int skipped;
  final int timedOut;
  final int xp;
  final int bestScore;
  final double bestAccuracy;
  final int bestStreak;
  final Duration fastestResponseTime;
  final Duration slowestResponseTime;

  _Totals({
    required this.questions,
    required this.correct,
    required this.incorrect,
    required this.skipped,
    required this.timedOut,
    required this.xp,
    required this.bestScore,
    required this.bestAccuracy,
    required this.bestStreak,
    required this.fastestResponseTime,
    required this.slowestResponseTime,
  });
}

class _Averages {
  final double accuracy;
  final int score;
  final Duration responseTime;

  _Averages({
    required this.accuracy,
    required this.score,
    required this.responseTime,
  });
}

class _Trends {
  final PerformanceTrend accuracy;
  final PerformanceTrend score;
  final PerformanceTrend speed;
  final PerformanceTrend xp;

  _Trends({
    required this.accuracy,
    required this.score,
    required this.speed,
    required this.xp,
  });
}
