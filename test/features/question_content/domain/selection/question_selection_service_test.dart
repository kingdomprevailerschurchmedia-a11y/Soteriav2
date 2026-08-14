import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/question_content/domain/repositories/question_repository.dart';
import 'package:soteria/features/question_content/domain/selection/question_selection_service.dart';
import 'package:soteria/features/question_content/domain/selection/selection_models.dart';

import 'question_selection_service_test.mocks.dart';

@GenerateMocks([QuestionRepository])
void main() {
  late MockQuestionRepository mockRepository;
  late QuestionSelectionService service;

  setUp(() {
    mockRepository = MockQuestionRepository();
    service = QuestionSelectionService(mockRepository);
  });

  final mockQuestions = [
    Question(
      id: 'q1',
      text: 'Science Q1',
      difficulty: Difficulty.easy,
      categoryId: 'science',
      type: QuestionType.multipleChoice,
      options: [],
      correctOptionIds: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      source: 'Test',
    ),
    Question(
      id: 'q2',
      text: 'Tech Q1',
      difficulty: Difficulty.easy,
      categoryId: 'technology',
      type: QuestionType.multipleChoice,
      options: [],
      correctOptionIds: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      source: 'Test',
    ),
  ];

  group('QuestionSelectionService', () {
    test('selectQuestions returns questions from requested category', () async {
      when(mockRepository.getQuestions(
        categoryId: 'science',
        difficulty: anyNamed('difficulty'),
        limit: anyNamed('limit'),
      )).thenAnswer((_) async => [mockQuestions[0]]);

      final request = const QuestionSelectionRequest(
        categoryIds: ['science'],
        questionCount: 1,
      );

      final result = await service.selectQuestions(request);

      expect(result.questions.length, 1);
      expect(result.questions[0].categoryId, 'science');
      expect(result.status, SelectionStatus.success);
    });

    test('selectQuestions handles insufficient content', () async {
      when(mockRepository.getQuestions(
        categoryId: 'science',
        difficulty: anyNamed('difficulty'),
        limit: anyNamed('limit'),
      )).thenAnswer((_) async => []);

      // No fallback provided in mock for this test
      when(mockRepository.getQuestions(
        difficulty: anyNamed('difficulty'),
        limit: anyNamed('limit'),
      )).thenAnswer((_) async => []);

      final request = const QuestionSelectionRequest(
        categoryIds: ['science'],
        questionCount: 5,
      );

      final result = await service.selectQuestions(request);

      expect(result.questions.isEmpty, true);
      expect(result.status, SelectionStatus.insufficientContent);
    });

    test('selectQuestions respects exclusions', () async {
      when(mockRepository.getQuestions(
        categoryId: 'science',
        difficulty: anyNamed('difficulty'),
        limit: anyNamed('limit'),
      )).thenAnswer((_) async => mockQuestions);

      final request = const QuestionSelectionRequest(
        categoryIds: ['science'],
        questionCount: 1,
        excludedQuestionIds: {'q1'},
      );

      final result = await service.selectQuestions(request);

      expect(result.questions.length, 1);
      expect(result.questions[0].id, 'q2');
    });

    test('selectQuestions falls back to general knowledge if no interests', () async {
      when(mockRepository.getQuestions(
        categoryId: 'general-knowledge',
        difficulty: anyNamed('difficulty'),
        limit: anyNamed('limit'),
      )).thenAnswer((_) async => [mockQuestions[0]]);

      final request = const QuestionSelectionRequest(
        categoryIds: [],
        questionCount: 1,
      );

      final result = await service.selectQuestions(request);

      expect(result.questions.length, 1);
      verify(mockRepository.getQuestions(
        categoryId: 'general-knowledge',
        difficulty: anyNamed('difficulty'),
        limit: anyNamed('limit'),
      )).called(1);
    });
  });
}
