import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/features/question_content/data/data_sources/firestore_data_source.dart';
import 'package:soteria/features/question_content/data/repositories/question_repository_impl.dart';
import 'package:soteria/features/question_content/data/models/question_dto.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

@GenerateNiceMocks([
  MockSpec<FirestoreQuestionDataSource>(),
])
import 'question_repository_test.mocks.dart';

void main() {
  late MockFirestoreQuestionDataSource mockDataSource;
  late QuestionRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockFirestoreQuestionDataSource();
    repository = QuestionRepositoryImpl(remoteSource: mockDataSource);
  });

  final mockDto = QuestionDto(
    id: 'q1',
    text: 'Test?',
    difficulty: 'easy',
    categoryId: 'cat1',
    type: 'multipleChoice',
    options: [
      const AnswerDto(id: 'o1', text: 'Ans1'),
      const AnswerDto(id: 'o2', text: 'Ans2'),
    ],
    correctOptionIds: ['o1'],
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
    source: 'S',
    status: 'published',
  );

  group('QuestionRepositoryImpl', () {
    test('getQuestions fetches from remote and caches', () async {
      when(mockDataSource.fetchQuestions(
        categoryId: anyNamed('categoryId'),
        subcategoryId: anyNamed('subcategoryId'),
        topicId: anyNamed('topicId'),
        difficulty: anyNamed('difficulty'),
        limit: anyNamed('limit'),
        status: anyNamed('status'),
        startAfterId: anyNamed('startAfterId'),
      )).thenAnswer((_) async => [mockDto]);

      final result = await repository.getQuestions(categoryId: 'cat1');

      expect(result.length, 1);
      expect(result.first.id, 'q1');
      verify(mockDataSource.fetchQuestions(categoryId: 'cat1', limit: 10)).called(1);
    });

    test('getQuestions falls back to cache on error', () async {
      // 1. Success first to populate cache
      when(mockDataSource.fetchQuestions(
        categoryId: anyNamed('categoryId'),
        limit: anyNamed('limit'),
      )).thenAnswer((_) async => [mockDto]);
      await repository.getQuestions(categoryId: 'cat1');

      // 2. Error on next call
      when(mockDataSource.fetchQuestions(
        categoryId: anyNamed('categoryId'),
        limit: anyNamed('limit'),
      )).thenThrow(Exception('Firestore Error'));

      final result = await repository.getQuestions(categoryId: 'cat1');
      expect(result.length, 1);
      expect(result.first.id, 'q1');
    });

    test('getQuestionById returns cached if available', () async {
      // Populate cache
      when(mockDataSource.fetchQuestions(limit: anyNamed('limit')))
          .thenAnswer((_) async => [mockDto]);
      await repository.getQuestions();

      // Should not call data source again
      final result = await repository.getQuestionById('q1');
      expect(result?.id, 'q1');
      verifyNever(mockDataSource.fetchQuestionById('q1'));
    });
  });
}
