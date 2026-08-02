import 'package:soteria/features/question_content/domain/entities/question.dart';

/// Strategy pattern for selecting questions from a pool.
/// Allows different game modes to provide unique selection logic.
abstract class QuestionSelectionStrategy {
  /// Selects a subset of questions from the provided pool based on specific logic.
  List<Question> select(List<Question> pool, int count);
}

/// A simple strategy that selects questions randomly.
class RandomSelectionStrategy implements QuestionSelectionStrategy {
  @override
  List<Question> select(List<Question> pool, int count) {
    final shuffled = List<Question>.from(pool)..shuffle();
    return shuffled.take(count).toList();
  }
}

/// A strategy that prioritizes questions by difficulty progression.
class ProgressiveDifficultyStrategy implements QuestionSelectionStrategy {
  @override
  List<Question> select(List<Question> pool, int count) {
    // Sort pool by difficulty (easy to expert) then take the first 'count'
    final sorted = List<Question>.from(pool)
      ..sort((a, b) => a.difficulty.index.compareTo(b.difficulty.index));
    return sorted.take(count).toList();
  }
}
