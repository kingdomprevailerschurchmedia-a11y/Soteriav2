import 'dart:math';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

abstract class AudienceSimulationStrategy {
  Map<String, double> simulate(Question question);
}

class DifficultyBasedSimulationStrategy implements AudienceSimulationStrategy {
  @override
  Map<String, double> simulate(Question question) {
    // Deterministic seed based on question ID
    final random = Random(question.id.hashCode);
    final results = <String, double>{};

    double correctProbability;
    switch (question.difficulty) {
      case Difficulty.easy:
        correctProbability = 0.85 + (random.nextDouble() * 0.10); // 85-95%
        break;
      case Difficulty.medium:
        correctProbability = 0.65 + (random.nextDouble() * 0.15); // 65-80%
        break;
      case Difficulty.hard:
        correctProbability = 0.45 + (random.nextDouble() * 0.15); // 45-60%
        break;
      case Difficulty.expert:
      case Difficulty.adaptive:
        correctProbability = 0.30 + (random.nextDouble() * 0.20); // 30-50%
        break;
    }

    final correctId = question.correctOptionIds.first;
    results[correctId] = correctProbability;

    final otherOptions = question.options
        .where((o) => o.id != correctId)
        .toList();
    double remainingProbability = 1.0 - correctProbability;

    for (int i = 0; i < otherOptions.length; i++) {
      if (i == otherOptions.length - 1) {
        results[otherOptions[i].id] = double.parse(
          remainingProbability.toStringAsFixed(4),
        );
      } else {
        // Distribute remaining randomly but weighted away from the correct answer
        final share = random.nextDouble() * remainingProbability;
        results[otherOptions[i].id] = double.parse(share.toStringAsFixed(4));
        remainingProbability -= share;
      }
    }

    return results;
  }
}
