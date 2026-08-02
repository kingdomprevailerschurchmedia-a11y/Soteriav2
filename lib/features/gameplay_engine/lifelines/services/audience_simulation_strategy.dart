import 'dart:math';
import 'package:soteria/features/question_content/domain/entities/question.dart';

abstract class AudienceSimulationStrategy {
  Map<String, double> simulate(Question question);
}

class DifficultyBasedSimulationStrategy implements AudienceSimulationStrategy {
  @override
  Map<String, double> simulate(Question question) {
    final random = Random();
    final results = <String, double>{};

    double correctProbability;
    switch (question.difficulty) {
      case QuestionDifficulty.easy:
        correctProbability = 0.90 + (random.nextDouble() * 0.05);
        break;
      case QuestionDifficulty.medium:
        correctProbability = 0.75 + (random.nextDouble() * 0.10);
        break;
      case QuestionDifficulty.hard:
        correctProbability = 0.60 + (random.nextDouble() * 0.10);
        break;
      case QuestionDifficulty.expert:
      case QuestionDifficulty.adaptive:
        correctProbability = 0.45 + (random.nextDouble() * 0.15);
        break;
    }

    final correctId = question.correctAnswers.first;
    results[correctId] = correctProbability;

    final otherOptions = question.options
        .where((o) => o.id != correctId)
        .toList();
    double remainingProbability = 1.0 - correctProbability;

    for (int i = 0; i < otherOptions.length; i++) {
      if (i == otherOptions.length - 1) {
        results[otherOptions[i].id] = remainingProbability;
      } else {
        final share = random.nextDouble() * remainingProbability;
        results[otherOptions[i].id] = share;
        remainingProbability -= share;
      }
    }

    return results;
  }
}
