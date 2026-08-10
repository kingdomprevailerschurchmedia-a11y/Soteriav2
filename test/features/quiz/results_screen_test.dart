import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import 'package:soteria/features/quiz/domain/models/quiz_result.dart';
import 'package:soteria/features/quiz/presentation/screens/quiz_results_screen.dart';
import 'package:soteria/features/quiz/presentation/providers/quiz_providers.dart';
import 'package:soteria/features/quiz/presentation/states/quiz_state.dart';
import 'package:soteria/features/quiz/presentation/controllers/quiz_controller.dart';

class _MockResultsController extends QuizController {
  _MockResultsController(this.initialState);
  final QuizState initialState;

  @override
  QuizState build() => initialState;
}

void main() {
  Widget buildTestableWidget(QuizState state) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, _) => ProviderScope(
        overrides: [
          quizControllerProvider.overrideWith(
            () => _MockResultsController(state),
          ),
        ],
        child: const MaterialApp(home: QuizResultsScreen()),
      ),
    );
  }

  group('QuizResultsScreen Widget Tests', () {
    final mockResult = QuizResult(
      sessionId: 's1',
      playerId: 'p1',
      gameMode: GameMode.practice,
      category: 'Science',
      difficulty: Difficulty.easy,
      totalQuestions: 2,
      answeredQuestions: 2,
      correctAnswers: 2,
      wrongAnswers: 0,
      skipped: 0,
      timedOut: 0,
      accuracy: 1.0,
      finalScore: 1500,
      xpEarned: 125,
      longestStreak: 2,
      finalStreak: 2,
      averageResponseTime: const Duration(seconds: 5),
      fastestResponseTime: const Duration(seconds: 3),
      slowestResponseTime: const Duration(seconds: 7),
      questionResults: [],
      completedAt: DateTime.now(),
      completionTime: const Duration(minutes: 1),
      performanceRating: 'Exceptional',
    );

    testWidgets('displays score and XP earned', (WidgetTester tester) async {
      final state = QuizState(status: QuizStatus.completed, result: mockResult);

      await tester.pumpWidget(buildTestableWidget(state));
      await tester.pumpAndSettle();

      expect(find.text('1500'), findsOneWidget);
      expect(find.text('+125 XP'), findsOneWidget);
      expect(find.text('EXCEPTIONAL'), findsOneWidget);
    });

    testWidgets('displays performance metrics', (WidgetTester tester) async {
      final state = QuizState(status: QuizStatus.completed, result: mockResult);

      await tester.pumpWidget(buildTestableWidget(state));
      await tester.pumpAndSettle();

      expect(find.text('100%'), findsOneWidget);
      expect(find.text('ACCURACY'), findsOneWidget);
      expect(find.text('2'), findsOneWidget); // Best streak
      expect(find.text('BEST STREAK'), findsOneWidget);
    });
  });
}
