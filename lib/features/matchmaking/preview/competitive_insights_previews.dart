import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/services/competitive_insights_service.dart';
import '../presentation/providers/match_result_providers.dart';
import '../presentation/screens/competitive_insights_screen.dart';
import 'package:soteria/features/analytics/domain/models/performance_trend.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';

class CompetitiveInsightsPreviews {
  static Widget standard() => ProviderScope(
    overrides: [
      competitiveInsightsProvider.overrideWith((ref) => Future.value(
        CompetitiveInsights(
          accuracyTrend: _mockTrend('Accuracy', [65, 70, 68, 75, 74, 80]),
          scoreTrend: _mockTrend('Score', [800, 950, 1100, 850, 1200, 1250]),
          recentForm: [
            CompetitiveOutcome.win,
            CompetitiveOutcome.win,
            CompetitiveOutcome.loss,
            CompetitiveOutcome.win,
            CompetitiveOutcome.win,
          ],
          categoryPerformance: {
            'Security': 85.0,
            'Cloud': 72.0,
            'Network': 68.0,
            'Coding': 90.0,
          },
          strongestCategory: 'Coding',
        ),
      )),
    ],
    child: const CompetitiveInsightsScreen(),
  );

  static PerformanceTrend _mockTrend(String label, List<double> values) {
    final points = values.asMap().entries.map((e) => PerformanceTrendPoint(
      date: DateTime.now().subtract(Duration(days: values.length - e.key)),
      value: e.value,
    )).toList();

    return PerformanceTrend(
      label: label,
      points: points,
      averageValue: values.reduce((a, b) => a + b) / values.length,
      minValue: values.reduce((a, b) => a < b ? a : b),
      maxValue: values.reduce((a, b) => a > b ? a : b),
      changeValue: 0,
      changePercentage: 0,
    );
  }
}
