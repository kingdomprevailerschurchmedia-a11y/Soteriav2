import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/selection/selection_strategy.dart';

void main() {
  group('SelectionStrategy Tests', () {
    final pool = List.generate(
      10,
      (i) => Question(
        id: 'id_$i',
        version: '1',
        text: 'Q$i',
        difficulty: i < 5 ? QuestionDifficulty.easy : QuestionDifficulty.hard,
        category: 'C',
        type: QuestionType.multipleChoice,
        options: [],
        correctAnswers: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'S',
        schemaVersion: 1,
        contentHash: 'H',
      ),
    );

    test('RandomSelectionStrategy returns correct count', () {
      final strategy = RandomSelectionStrategy();
      final result = strategy.select(pool, 3);
      expect(result.length, 3);
      expect(pool, containsAll(result));
    });

    test('ProgressiveDifficultyStrategy sorts by difficulty', () {
      final strategy = ProgressiveDifficultyStrategy();
      final result = strategy.select(pool, 10);

      expect(result.first.difficulty, QuestionDifficulty.easy);
      expect(result.last.difficulty, QuestionDifficulty.hard);
    });
  });
}
