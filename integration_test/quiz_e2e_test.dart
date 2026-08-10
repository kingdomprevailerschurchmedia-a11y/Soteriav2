import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/app/app.dart';
import 'package:soteria/features/quiz/presentation/providers/quiz_providers.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart' as quiz_enums;
import 'package:soteria/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:soteria/features/quiz/domain/models/question.dart';
import 'package:soteria/features/quiz/domain/models/quiz_session.dart';
import 'package:soteria/features/quiz/domain/models/quiz_result.dart';
import 'package:soteria/features/quiz/domain/models/player_answer.dart';
import 'package:soteria/features/quiz/domain/models/answer_option.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_session.dart';

class MockQuizRepository implements QuizRepository {
  @override
  Future<List<Question>> loadQuestions({
    required quiz_enums.GameMode mode,
    required String category,
    required quiz_enums.Difficulty difficulty,
  }) async {
    return [
      Question(
        id: 'q1',
        type: quiz_enums.QuestionType.multipleChoice,
        category: 'Math',
        difficulty: quiz_enums.Difficulty.easy,
        text: 'What is 1+1?',
        options: [
          const AnswerOption(id: 'a1', text: '2'),
          const AnswerOption(id: 'a2', text: '3'),
        ],
        correctOptionIds: ['a1'],
        estimatedTime: 30,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  @override
  Future<QuizSession> createSession({
    required String playerId,
    required quiz_enums.GameMode mode,
    required String category,
    required quiz_enums.Difficulty difficulty,
  }) async {
    return QuizSession(
      sessionId: 'test-session',
      playerId: playerId,
      gameMode: mode,
      category: category,
      difficulty: difficulty,
      startedTime: DateTime.now(),
    );
  }

  @override
  Future<QuizSession?> restoreSession(String sessionId) async => null;
  @override
  Future<PlayerAnswer> submitAnswer({required String sessionId, required PlayerAnswer answer}) async => answer;
  @override
  Future<QuizResult> finishSession(String sessionId) async => throw UnimplementedError();
  @override
  Future<int> calculateScore(String sessionId) async => 0;
  @override
  Future<void> saveProgress(QuizSession session) async {}
  @override
  Future<QuizSession?> loadProgress(String sessionId) async => null;
  @override
  Future<bool> validateAnswer({required String questionId, required List<String> selectedOptionIds}) async => true;
  @override
  Future<void> syncSession(String sessionId) async {}
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Quiz End-to-End Certification', () {
    testWidgets('Perfect Quiz Run', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            quizRepositoryProvider.overrideWithValue(MockQuizRepository()),
            sessionProvider.overrideWith(() => SessionNotifier()), // Default guest session or custom
          ],
          child: const SoteriaApp(),
        ),
      );

      await tester.pumpAndSettle();

      final container = ProviderScope.containerOf(tester.element(find.byType(SoteriaApp)));
      
      // Manually set session to authenticated for test
      container.read(sessionProvider.notifier).setSession(const UserSession(
        uid: 'test-user',
        status: SessionStatus.authenticated,
      ));

      final quizController = container.read(quizControllerProvider.notifier);
      
      await quizController.startQuiz(
        playerId: 'test-user',
        mode: quiz_enums.GameMode.practice,
        category: 'Math',
        difficulty: quiz_enums.Difficulty.easy,
      );

      await tester.pumpAndSettle();

      expect(find.text('What is 1+1?'), findsOneWidget);
      
      await tester.tap(find.text('2'));
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('QUIZ COMPLETE'), findsOneWidget);
    });
  });
}
