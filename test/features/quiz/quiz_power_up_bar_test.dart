import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import 'package:soteria/features/quiz/domain/models/power_up_state.dart';
import 'package:soteria/features/quiz/presentation/widgets/quiz_power_up_bar.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, _) => MaterialApp(
        home: Scaffold(body: Column(children: [const Spacer(), child])),
      ),
    );
  }

  group('QuizPowerUpBar Widget Tests', () {
    testWidgets('displays all power-up types', (WidgetTester tester) async {
      final powerUps = [
        const PowerUpState(type: PowerUpType.fiftyFifty),
        const PowerUpState(type: PowerUpType.pauseTimer),
        const PowerUpState(type: PowerUpType.askAudience),
      ];

      await tester.pumpWidget(
        buildTestableWidget(QuizPowerUpBar(powerUps: powerUps)),
      );

      expect(find.text('50/50'), findsOneWidget);
      expect(find.text('PAUSE'), findsOneWidget);
      expect(find.text('POLL'), findsOneWidget);
    });

    testWidgets('calls onPowerUpTap when available', (
      WidgetTester tester,
    ) async {
      PowerUpType? tappedType;
      final powerUps = [
        const PowerUpState(
          type: PowerUpType.fiftyFifty,
          status: PowerUpStatus.available,
        ),
      ];

      await tester.pumpWidget(
        buildTestableWidget(
          QuizPowerUpBar(
            powerUps: powerUps,
            onPowerUpTap: (type) => tappedType = type,
          ),
        ),
      );

      await tester.tap(find.text('50/50'));
      await tester.pump();

      expect(tappedType, equals(PowerUpType.fiftyFifty));
    });

    testWidgets('does not call onPowerUpTap when used', (
      WidgetTester tester,
    ) async {
      PowerUpType? tappedType;
      final powerUps = [
        const PowerUpState(
          type: PowerUpType.fiftyFifty,
          status: PowerUpStatus.used,
        ),
      ];

      await tester.pumpWidget(
        buildTestableWidget(
          QuizPowerUpBar(
            powerUps: powerUps,
            onPowerUpTap: (type) => tappedType = type,
          ),
        ),
      );

      await tester.tap(find.text('50/50'));
      await tester.pump();

      expect(tappedType, isNull);
    });

    testWidgets('shows loading indicator when activating', (
      WidgetTester tester,
    ) async {
      final powerUps = [
        const PowerUpState(
          type: PowerUpType.fiftyFifty,
          status: PowerUpStatus.activating,
        ),
      ];

      await tester.pumpWidget(
        buildTestableWidget(QuizPowerUpBar(powerUps: powerUps)),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
