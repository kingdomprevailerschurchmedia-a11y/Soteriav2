import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/question_content/data/validators/question_validator.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

void main() {
  group('QuestionValidator', () {
    test('valid question passes', () {
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
      expect(QuestionValidator.validate(q), isEmpty);
    });

    test('missing text fails', () {
      final q = Question(
        id: '1',
        text: '',
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
      final errors = QuestionValidator.validate(q);
      expect(errors, contains('Question text cannot be empty.'));
    });

    test('MC with multiple correct fails', () {
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
        correctOptionIds: ['o1', 'o2'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'S',
      );
      final errors = QuestionValidator.validate(q);
      expect(errors, contains('Multiple choice questions must have exactly one correct option.'));
    });

    test('duplicate options fails', () {
      final q = Question(
        id: '1',
        text: 'Test?',
        difficulty: Difficulty.easy,
        categoryId: 'cat1',
        type: QuestionType.multipleChoice,
        options: [
          const Answer(id: 'o1', text: 'Duplicate'),
          const Answer(id: 'o2', text: 'Duplicate'),
        ],
        correctOptionIds: ['o1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'S',
      );
      final errors = QuestionValidator.validate(q);
      expect(errors, contains('Question contains duplicate option text.'));
    });

    test('invalid correct option ID fails', () {
      final q = Question(
        id: '1',
        text: 'Test?',
        difficulty: Difficulty.easy,
        categoryId: 'cat1',
        type: QuestionType.multipleChoice,
        options: [
          const Answer(id: 'o1', text: 'Ans1'),
        ],
        correctOptionIds: ['invalid_id'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'S',
      );
      final errors = QuestionValidator.validate(q);
      expect(errors, contains('Correct option ID "invalid_id" does not exist in options.'));
    });
  });
}
