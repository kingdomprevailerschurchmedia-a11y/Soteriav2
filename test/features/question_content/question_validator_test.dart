import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/data/validators/question_validator.dart';

void main() {
  group('QuestionValidator Tests', () {
    test('valid question returns no errors', () {
      final question = Question(
        version: '1.0',
        text: 'What is 2+2?',
        difficulty: QuestionDifficulty.easy,
        category: 'Math',
        type: QuestionType.multipleChoice,
        options: [
          const Answer(id: '1', text: '3'),
          const Answer(id: '2', text: '4'),
        ],
        correctAnswers: ['2'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Internal',
        schemaVersion: 1,
        contentHash: 'abc',
      );

      final errors = QuestionValidator.validate(question);
      expect(errors, isEmpty);
    });

    test('missing text returns error', () {
      final question = Question(
        version: '1.0',
        text: '',
        difficulty: QuestionDifficulty.easy,
        category: 'Math',
        type: QuestionType.multipleChoice,
        options: [const Answer(id: '1', text: '4')],
        correctAnswers: ['1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Internal',
        schemaVersion: 1,
        contentHash: 'abc',
      );

      final errors = QuestionValidator.validate(question);
      expect(errors, contains('Question text cannot be empty.'));
    });

    test('invalid correct answer ID returns error', () {
      final question = Question(
        version: '1.0',
        text: 'Q',
        difficulty: QuestionDifficulty.easy,
        category: 'C',
        type: QuestionType.multipleChoice,
        options: [const Answer(id: '1', text: 'A')],
        correctAnswers: ['999'], // Non-existent ID
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Internal',
        schemaVersion: 1,
        contentHash: 'abc',
      );

      final errors = QuestionValidator.validate(question);
      expect(
        errors,
        contains('Correct answer ID "999" does not exist in options.'),
      );
    });

    test('duplicate options return error', () {
      final question = Question(
        version: '1.0',
        text: 'Q',
        difficulty: QuestionDifficulty.easy,
        category: 'C',
        type: QuestionType.multipleChoice,
        options: [
          const Answer(id: '1', text: 'A'),
          const Answer(id: '2', text: 'A'), // Duplicate
        ],
        correctAnswers: ['1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Internal',
        schemaVersion: 1,
        contentHash: 'abc',
      );

      final errors = QuestionValidator.validate(question);
      expect(errors, contains('Question contains duplicate options.'));
    });
  });
}
