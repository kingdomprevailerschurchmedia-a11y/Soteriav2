import '../models/practice_result.dart';
import '../../../../features/gameplay_engine/models/game_result.dart';

class PracticeInsightEngine {
  static const int minSampleThreshold = 3;

  static List<LearningInsight> generateInsights(PracticeResult result, {List<GameResult> history = const []}) {
    final insights = <LearningInsight>[];

    // 1. Detect Strengths
    for (final perf in result.categoryPerformance.values) {
      if (perf.total >= minSampleThreshold && perf.accuracy >= 0.85) {
        insights.add(LearningInsight(
          title: 'Strong Category',
          description: '${perf.categoryId.toUpperCase()} is one of your strongest areas!',
          type: LearningInsightType.strength,
          isPositive: true,
        ));
      }
    }

    // 2. Detect Weaknesses
    for (final perf in result.categoryPerformance.values) {
      if (perf.total >= minSampleThreshold && perf.accuracy < 0.6) {
        insights.add(LearningInsight(
          title: 'Improvement Opportunity',
          description: '${perf.categoryId.toUpperCase()} could use more practice.',
          type: LearningInsightType.weakness,
          isPositive: false,
        ));
      }
    }

    // 3. Overall Performance Insight
    if (result.accuracy >= 0.9) {
      insights.add(const LearningInsight(
        title: 'Mastery Level',
        description: 'You demonstrated exceptional knowledge in this session.',
        type: LearningInsightType.consistency,
        isPositive: true,
      ));
    } else if (result.accuracy < 0.4) {
      insights.add(const LearningInsight(
        title: 'Needs Focus',
        description: 'Try reviewing the explanations for your incorrect answers.',
        type: LearningInsightType.challenge,
        isPositive: false,
      ));
    }

    // 4. Difficulty Insights
    result.difficultyPerformance.forEach((difficulty, accuracy) {
      if (accuracy < 0.5) {
        insights.add(LearningInsight(
          title: 'Challenge Level',
          description: '${difficulty.name.toUpperCase()} questions are currently your biggest challenge.',
          type: LearningInsightType.challenge,
          isPositive: false,
        ));
      }
    });

    // 5. Improvement Detection
    if (history.isNotEmpty) {
      final prevResult = history.first; // Assuming history is sorted by date descending
      final diff = result.accuracy - prevResult.accuracy;
      if (diff >= 0.15) {
        insights.add(LearningInsight(
          title: 'Great Improvement',
          description: 'Your accuracy improved by ${(diff * 100).toInt()}% compared to your last session!',
          type: LearningInsightType.improvement,
          isPositive: true,
        ));
      }
    }

    return insights;
  }
}
