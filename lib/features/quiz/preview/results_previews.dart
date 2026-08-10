import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/quiz_enums.dart';
import '../domain/models/quiz_result.dart';
import '../domain/models/question_result.dart';
import '../presentation/states/quiz_state.dart';
import '../presentation/controllers/quiz_controller.dart';
import '../presentation/providers/quiz_providers.dart';
import '../presentation/screens/quiz_results_screen.dart';

class ResultsPreviewWrapper extends StatelessWidget {
  const ResultsPreviewWrapper({super.key, required this.state});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        quizControllerProvider.overrideWith(
          () => _MockResultsController(state),
        ),
      ],
      child: const QuizResultsScreen(),
    );
  }
}

class _MockResultsController extends QuizController {
  _MockResultsController(this.initialState);
  final QuizState initialState;

  @override
  QuizState build() => initialState;
}

class ResultsPreviews {
  static QuizResult mockResult({
    double accuracy = 0.85,
    int score = 1850,
    int xp = 125,
    String rating = 'Excellent',
  }) {
    return QuizResult(
      sessionId: 'mock_s1',
      playerId: 'p1',
      gameMode: GameMode.practice,
      category: 'Cybersecurity',
      difficulty: Difficulty.hard,
      totalQuestions: 10,
      answeredQuestions: 10,
      correctAnswers: (10 * accuracy).round(),
      wrongAnswers: (10 * (1 - accuracy)).round(),
      skipped: 0,
      timedOut: 0,
      accuracy: accuracy,
      finalScore: score,
      xpEarned: xp,
      longestStreak: 7,
      finalStreak: 3,
      averageResponseTime: const Duration(seconds: 8, milliseconds: 400),
      fastestResponseTime: const Duration(seconds: 2, milliseconds: 100),
      slowestResponseTime: const Duration(seconds: 15, milliseconds: 200),
      questionResults: [
        const QuestionResult(
          questionId: 'q1',
          questionNumber: 1,
          questionText: 'What does AES stand for?',
          outcome: QuestionOutcome.correct,
          selectedOptionId: 'o1',
          selectedOptionText: 'Advanced Encryption Standard',
          correctOptionIds: ['o1'],
          correctOptionText: 'Advanced Encryption Standard',
          responseTime: Duration(seconds: 4),
          scoreEarned: 100,
        ),
        const QuestionResult(
          questionId: 'q2',
          questionNumber: 2,
          questionText: 'Which port is used by HTTPS?',
          outcome: QuestionOutcome.incorrect,
          selectedOptionId: 'o2',
          selectedOptionText: '80',
          correctOptionIds: ['o1'],
          correctOptionText: '443',
          responseTime: Duration(seconds: 6),
          scoreEarned: 0,
          explanation: 'HTTPS uses port 443. Port 80 is used by HTTP.',
        ),
      ],
      completedAt: DateTime.now(),
      completionTime: const Duration(minutes: 5),
      performanceRating: rating,
    );
  }

  static Widget excellent() => ResultsPreviewWrapper(
    state: QuizState(status: QuizStatus.completed, result: mockResult()),
  );

  static Widget perfect() => ResultsPreviewWrapper(
    state: QuizState(
      status: QuizStatus.completed,
      result: mockResult(
        accuracy: 1.0,
        score: 2500,
        xp: 250,
        rating: 'Exceptional',
      ),
    ),
  );

  static Widget average() => ResultsPreviewWrapper(
    state: QuizState(
      status: QuizStatus.completed,
      result: mockResult(accuracy: 0.6, score: 950, xp: 60, rating: 'Good'),
    ),
  );
}
