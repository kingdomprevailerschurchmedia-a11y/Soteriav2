import '../../../player/domain/models/competitive_match.dart';
import '../../../player/domain/models/competitive_result.dart';
import '../../../analytics/domain/models/performance_trend.dart';

class CompetitiveInsights {
  final PerformanceTrend accuracyTrend;
  final PerformanceTrend scoreTrend;
  final List<CompetitiveOutcome> recentForm;
  final Map<String, double> categoryPerformance;
  final String strongestCategory;

  CompetitiveInsights({
    required this.accuracyTrend,
    required this.scoreTrend,
    required this.recentForm,
    required this.categoryPerformance,
    required this.strongestCategory,
  });
}

class CompetitiveInsightsService {
  CompetitiveInsights calculateInsights(List<CompetitiveMatch> history) {
    if (history.isEmpty) {
      return CompetitiveInsights(
        accuracyTrend: _emptyTrend('Accuracy'),
        scoreTrend: _emptyTrend('Score'),
        recentForm: [],
        categoryPerformance: {},
        strongestCategory: 'None',
      );
    }

    final reversedHistory = history.reversed.toList();
    
    final accuracyPoints = reversedHistory.map((m) => PerformanceTrendPoint(
      date: m.result.completedAt,
      value: (m.quizResult?.accuracy ?? 0.0) * 100,
    )).toList();

    final scorePoints = reversedHistory.map((m) => PerformanceTrendPoint(
      date: m.result.completedAt,
      value: m.result.score.toDouble(),
    )).toList();

    final recentForm = history.take(5).map((m) => m.result.outcome).toList();

    // Simplified strongest category calculation
    final categoryMap = <String, List<double>>{};
    for (final match in history) {
      final category = match.quizResult?.sessionId.split('_').first ?? 'General'; // Placeholder logic
      categoryMap.putIfAbsent(category, () => []).add(match.quizResult?.accuracy ?? 0.0);
    }

    final categoryPerformance = categoryMap.map((key, values) => 
      MapEntry(key, values.reduce((a, b) => a + b) / values.length * 100));
    
    String strongest = 'None';
    double maxAcc = -1.0;
    categoryPerformance.forEach((key, value) {
      if (value > maxAcc) {
        maxAcc = value;
        strongest = key;
      }
    });

    return CompetitiveInsights(
      accuracyTrend: _createTrend('Accuracy', accuracyPoints),
      scoreTrend: _createTrend('Score', scorePoints),
      recentForm: recentForm,
      categoryPerformance: categoryPerformance,
      strongestCategory: strongest,
    );
  }

  PerformanceTrend _createTrend(String label, List<PerformanceTrendPoint> points) {
    final values = points.map((p) => p.value).toList();
    final avg = values.isEmpty ? 0.0 : values.reduce((a, b) => a + b) / values.length;
    return PerformanceTrend(
      label: label,
      points: points,
      averageValue: avg,
      minValue: values.isEmpty ? 0.0 : values.reduce((a, b) => a < b ? a : b),
      maxValue: values.isEmpty ? 100.0 : values.reduce((a, b) => a > b ? a : b),
      changeValue: 0, // Simplified
      changePercentage: 0,
    );
  }

  PerformanceTrend _emptyTrend(String label) => PerformanceTrend(
    label: label,
    points: [],
    averageValue: 0,
    minValue: 0,
    maxValue: 100,
    changeValue: 0,
    changePercentage: 0,
  );
}
