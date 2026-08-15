import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocktail/mocktail.dart' as mt;
import 'package:soteria/features/gameplay_engine/pages/pro_mode_results_screen.dart';
import 'package:soteria/features/gameplay_engine/providers/pro_mode_results_provider.dart';
import 'package:soteria/features/gameplay_engine/models/pro_mode_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

class MockProModeResultsNotifier extends mt.Mock implements ProModeResultsNotifier {}

void main() {
  testWidgets('ProModeResultsScreen displays correct metrics', (WidgetTester tester) async {
    final result = ProModeResult(
      playerId: 'test-player',
      sessionId: 'test-session',
      mode: GameMode.pro,
      finalScore: 1000,
      totalXP: 100,
      totalQuestions: 10,
      correctAnswers: 9,
      wrongAnswers: 1,
      totalDuration: const Duration(minutes: 2),
      accuracy: 0.9,
      maxStreak: 5,
      timestamp: DateTime.now(),
      rating: 'A',
    );

    final mockNotifier = MockProModeResultsNotifier();
    mt.when(() => mockNotifier.state).thenReturn(ProModeResultsState(result: AsyncValue.data(result)));
    mt.when(() => mockNotifier.stream).thenAnswer((_) => Stream.value(ProModeResultsState(result: AsyncValue.data(result))));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          proModeResultsProvider.overrideWith((ref) => mockNotifier),
        ],
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (context, child) => const MaterialApp(
            home: ProModeResultsScreen(sessionId: 'test-session'),
          ),
        ),
      ),
    );

    await tester.runAsync(() async {
      await Future.delayed(const Duration(seconds: 1));
    });
    await tester.pumpAndSettle();

    expect(find.text('PRO MODE COMPLETE'), findsOneWidget);
    expect(find.text('1000'), findsOneWidget); // Score
    expect(find.text('90%'), findsOneWidget); // Accuracy
    expect(find.text('A'), findsOneWidget); // Rating
  });
}
