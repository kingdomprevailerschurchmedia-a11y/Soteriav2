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

/// A strategy that attempts to balance questions across multiple categories.
class BalancedCategoryStrategy implements QuestionSelectionStrategy {
  @override
  List<Question> select(List<Question> pool, int count) {
    if (pool.isEmpty || count <= 0) return [];

    // Group questions by category
    final Map<String, List<Question>> byCategory = {};
    for (final q in pool) {
      byCategory.putIfAbsent(q.categoryId, () => []).add(q);
    }

    final categories = byCategory.keys.toList();
    if (categories.isEmpty) return [];

    // Shuffle questions within each category
    for (final cat in categories) {
      byCategory[cat]!.shuffle();
    }

    final List<Question> selected = [];
    int catIndex = 0;

    // Round-robin selection
    while (selected.length < count) {
      final categoryId = categories[catIndex % categories.length];
      final categoryPool = byCategory[categoryId]!;

      if (categoryPool.isNotEmpty) {
        selected.add(categoryPool.removeAt(0));
      }

      // If all pools are exhausted, break to avoid infinite loop
      if (byCategory.values.every((list) => list.isEmpty)) {
        break;
      }

      catIndex++;
    }

    return selected;
  }
}
