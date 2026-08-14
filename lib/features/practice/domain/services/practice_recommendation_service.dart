import '../models/practice_result.dart';
import '../../../question_content/domain/entities/difficulty.dart';

class PracticeRecommendationService {
  static PracticeRecommendation? recommendNext(PracticeResult result) {
    // 1. Recommend Weak Area Focus
    final weaknesses = result.insights.where((i) => i.type == LearningInsightType.weakness).toList();
    if (weaknesses.isNotEmpty) {
      // Find the CategoryPerformance for the first weakness
      final catId = result.categoryPerformance.values
          .where((p) => weaknesses.first.description.contains(p.categoryId.toUpperCase()))
          .map((p) => p.categoryId)
          .firstOrNull;

      if (catId != null) {
        return PracticeRecommendation(
          title: 'Strengthen Weak Areas',
          description: 'Focus on $catId to improve your overall accuracy.',
          categoryId: catId,
          difficulty: result.reviewItems.firstWhere((r) => r.categoryId == catId).difficulty,
          questionCount: 10,
        );
      }
    }

    // 2. Recommend Increasing Difficulty
    if (result.accuracy >= 0.9) {
      final currentDifficulty = result.reviewItems.first.difficulty;
      final nextDifficulty = _getNextDifficulty(currentDifficulty);
      if (nextDifficulty != currentDifficulty) {
        return PracticeRecommendation(
          title: 'Level Up Challenge',
          description: 'You\u0027ve mastered this level! Try ${nextDifficulty.name.toUpperCase()} for more challenge.',
          categoryId: result.reviewItems.first.categoryId,
          difficulty: nextDifficulty,
          questionCount: 10,
        );
      }
    }

    // 3. Default: Practice Again with Same Settings
    if (result.reviewItems.isNotEmpty) {
      final item = result.reviewItems.first;
      return PracticeRecommendation(
        title: 'Consistency is Key',
        description: 'Practice again to solidify your knowledge in ${item.categoryId}.',
        categoryId: item.categoryId,
        difficulty: item.difficulty,
        questionCount: result.totalQuestions,
      );
    }

    return null;
  }

  static Difficulty _getNextDifficulty(Difficulty current) {
    switch (current) {
      case Difficulty.easy: return Difficulty.medium;
      case Difficulty.medium: return Difficulty.hard;
      case Difficulty.hard: return Difficulty.expert;
      case Difficulty.expert: return Difficulty.expert;
      case Difficulty.adaptive: return Difficulty.adaptive;
    }
  }
}
