import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/question_content/data/mappers/question_mapper.dart';
import 'package:soteria/features/question_content/data/models/question_dto.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

void main() {
  group('QuestionMapper', () {
    test('mapping works correctly', () {
      final dto = QuestionDto(
        id: 'q1',
        text: 'Text',
        difficulty: 'easy',
        categoryId: 'cat1',
        type: 'multipleChoice',
        options: [
          const AnswerDto(id: 'o1', text: 'Ans1'),
        ],
        correctOptionIds: ['o1'],
        createdAt: '2023-01-01T00:00:00.000Z',
        updatedAt: '2023-01-01T00:00:00.000Z',
        source: 'S',
      );

      final entity = QuestionMapper.fromDto(dto);
      expect(entity.id, dto.id);
      expect(entity.difficulty, Difficulty.easy);
      expect(entity.type, QuestionType.multipleChoice);

      final backToDto = QuestionMapper.toDto(entity);
      expect(backToDto.id, dto.id);
      expect(backToDto.correctOptionIds, dto.correctOptionIds);
    });

    test('stripCorrectAnswers works', () {
      final q = Question(
        id: '1',
        text: 'Test?',
        difficulty: Difficulty.easy,
        categoryId: 'cat1',
        type: QuestionType.multipleChoice,
        options: [const Answer(id: 'o1', text: 'Ans')],
        correctOptionIds: ['o1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'S',
      );

      final stripped = QuestionMapper.stripCorrectAnswers(q);
      expect(stripped.correctOptionIds, isEmpty);
      expect(stripped.text, q.text);
    });
  });
}
