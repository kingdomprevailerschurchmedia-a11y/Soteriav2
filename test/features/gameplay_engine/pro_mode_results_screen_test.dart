import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mockito/mockito.dart';
import 'package:soteria/features/gameplay_engine/pages/pro_mode_results_screen.dart';
import 'package:soteria/features/gameplay_engine/providers/pro_mode_results_provider.dart';
import 'package:soteria/features/gameplay_engine/models/pro_mode_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

class MockRef extends Mock implements Ref {}

void main() {
  testWidgets('ProModeResultsScreen displays correct metrics', (WidgetTester tester) async {
    final result = ProModeResult(
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

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          proModeResultsProvider.overrideWith((ref) => _FakeResultsNotifier(result)),
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
      await Future.delayed(const Duration(seconds: 3));
    });
    await tester.pumpAndSettle();

    expect(find.text('PRO MODE COMPLETE'), findsOneWidget);
    expect(find.text('1000'), findsOneWidget); // Score
    expect(find.text('90%'), findsOneWidget); // Accuracy
    expect(find.text('A'), findsOneWidget); // Rating
    
    await tester.pump(const Duration(seconds: 5));
  });
}

class _FakeResultsNotifier extends ProModeResultsNotifier {
  final ProModeResult mockResult;

  _FakeResultsNotifier(this.mockResult) : super(MockRef()) {
    state = ProModeResultsState(result: AsyncValue.data(mockResult));
  }

  @override
  Future<void> loadResult(String sessionId) async {}
  
  @override
  Future<void> completeSession(dynamic s) async {}
}
