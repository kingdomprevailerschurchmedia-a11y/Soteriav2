import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

void main() {
  group('Question Entity', () {
    test('equality works', () {
      final q1 = Question(
        id: '1',
        text: 'Test?',
        difficulty: Difficulty.easy,
        categoryId: 'cat1',
        type: QuestionType.multipleChoice,
        options: [const Answer(id: 'o1', text: 'Ans')],
        correctOptionIds: ['o1'],
        createdAt: DateTime(2023),
        updatedAt: DateTime(2023),
        source: 'S',
      );
      final q2 = Question(
        id: '1',
        text: 'Test?',
        difficulty: Difficulty.easy,
        categoryId: 'cat1',
        type: QuestionType.multipleChoice,
        options: [const Answer(id: 'o1', text: 'Ans')],
        correctOptionIds: ['o1'],
        createdAt: DateTime(2023),
        updatedAt: DateTime(2023),
        source: 'S',
      );
      expect(q1, equals(q2));
    });

    test('isAnswerCorrect works', () {
      final q = Question(
        id: '1',
        text: 'Test?',
        difficulty: Difficulty.easy,
        categoryId: 'cat1',
        type: QuestionType.multipleChoice,
        options: [
          const Answer(id: 'o1', text: 'Ans1'),
          const Answer(id: 'o2', text: 'Ans2'),
        ],
        correctOptionIds: ['o1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'S',
      );
      expect(q.isAnswerCorrect('o1'), isTrue);
      expect(q.isAnswerCorrect('o2'), isFalse);
    });

    test('areAnswersCorrect works for single correct', () {
      final q = Question(
        id: '1',
        text: 'Test?',
        difficulty: Difficulty.easy,
        categoryId: 'cat1',
        type: QuestionType.multipleChoice,
        options: [
          const Answer(id: 'o1', text: 'Ans1'),
          const Answer(id: 'o2', text: 'Ans2'),
        ],
        correctOptionIds: ['o1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'S',
      );
      expect(q.areAnswersCorrect(['o1']), isTrue);
      expect(q.areAnswersCorrect(['o2']), isFalse);
      expect(q.areAnswersCorrect(['o1', 'o2']), isFalse);
    });
  });
}
