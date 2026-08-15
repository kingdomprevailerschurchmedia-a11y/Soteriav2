import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/practice/presentation/providers/practice_providers.dart';
import 'package:soteria/features/practice/presentation/providers/practice_history_providers.dart';
import 'package:soteria/features/analytics/presentation/providers/analytics_providers.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/practice/domain/repositories/practice_result_repository.dart';
import 'package:soteria/features/analytics/domain/repositories/question_analytics_repository.dart';
import 'package:soteria/features/auth/domain/repositories/auth_repository.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart' as quiz_enums;
import 'package:soteria/features/quiz/domain/models/question_result.dart';

import 'practice_analytics_integration_test.mocks.dart';

@GenerateMocks([QuestionAnalyticsRepository, PracticeResultRepository, AuthRepository])
void main() {
  late MockQuestionAnalyticsRepository mockAnalyticsRepo;
  late MockPracticeResultRepository mockPracticeRepo;
  late MockAuthRepository mockAuthRepo;

  setUp(() {
    mockAnalyticsRepo = MockQuestionAnalyticsRepository();
    mockPracticeRepo = MockPracticeResultRepository();
    mockAuthRepo = MockAuthRepository();

    when(mockAuthRepo.currentUserId).thenReturn('user123');
    when(mockPracticeRepo.recordResult(any)).thenAnswer((_) async => {});
    when(mockAnalyticsRepo.recordEvent(any, any, any)).thenAnswer((_) async => {});
  });

  test('Practice session finalization triggers analytics for each question', () async {
    final container = ProviderContainer(
      overrides: [
        questionAnalyticsRepositoryProvider.overrideWithValue(mockAnalyticsRepo),
        practiceResultRepositoryProvider.overrideWithValue(mockPracticeRepo),
        authRepositoryProvider.overrideWithValue(mockAuthRepo),
      ],
    );
    
    final question = Question(
      id: 'q1',
      text: 'Test',
      categoryId: 'science',
      difficulty: Difficulty.medium,
      options: [],
      correctOptionIds: ['o1'],
      version: '1.0.0',
      type: QuestionType.multipleChoice,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      source: 'Test',
    );

    final gameState = GameState(
      playerId: 'test-player',
      sessionId: 'session123',
      questions: [question],
      answerHistory: [], 
    );

    final notifier = container.read(practiceResultProvider.notifier);
    
    await notifier.finalize(gameState);

    verify(mockPracticeRepo.recordResult(any)).called(1);
    
    final captured = verify(mockAnalyticsRepo.recordEvent(any, any, captureAny)).captured.first as QuestionResult;
    expect(captured.questionId, 'q1');
    expect(captured.categoryId, 'science');
    expect(captured.questionVersion, '1.0.0');
    expect(captured.mode, quiz_enums.GameMode.practice);
  });
}
