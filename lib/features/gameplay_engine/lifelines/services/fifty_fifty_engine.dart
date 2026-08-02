import 'dart:math';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_type.dart';
import 'package:soteria/features/gameplay_engine/lifelines/services/lifeline_engine.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

class FiftyFiftyEngine implements LifelineEngine {
  @override
  LifelineType get type => LifelineType.fiftyFifty;

  @override
  Future<List<String>> activate({
    required Question question,
    Map<String, dynamic>? context,
  }) async {
    final correctIds = question.correctAnswers;
    final incorrectOptions = question.options
        .where((o) => !correctIds.contains(o.id))
        .toList();

    if (incorrectOptions.length < 2)
      return []; // Should not happen with standard 4-option questions

    // Randomly pick 2 incorrect answers to remove
    final random = Random();
    incorrectOptions.shuffle(random);

    return incorrectOptions.take(2).map((o) => o.id).toList();
  }
}
