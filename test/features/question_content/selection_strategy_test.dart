import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/question_content/domain/selection/selection_strategy.dart';

void main() {
  group('SelectionStrategy Tests', () {
    final pool = List.generate(
      10,
      (i) => Question(
        id: 'id_$i',
        text: 'Q$i',
        difficulty: i < 5 ? Difficulty.easy : Difficulty.hard,
        categoryId: 'C',
        type: QuestionType.multipleChoice,
        options: const [
          Answer(id: 'o1', text: 'A'),
          Answer(id: 'o2', text: 'B'),
        ],
        correctOptionIds: const ['o1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'S',
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

      expect(result.first.difficulty, Difficulty.easy);
      expect(result.last.difficulty, Difficulty.hard);
    });
  });
}
