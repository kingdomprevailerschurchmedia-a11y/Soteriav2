import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/player/presentation/widgets/season_header.dart';
import 'package:soteria/features/player/presentation/widgets/season_countdown_widget.dart';
import 'package:soteria/features/player/domain/models/season_countdown.dart';
import 'package:soteria/features/player/preview/season_previews.dart';
import 'package:soteria/core/design_system/themes/soteria_theme.dart';

void main() {
  Widget wrap(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, _) => MaterialApp(
        theme: SoteriaTheme.darkTheme,
        home: Scaffold(body: child),
      ),
    );
  }

  group('Season UI Components', () {
    testWidgets('SeasonCountdownWidget should show D:H:M:S when days > 0', (
      WidgetTester tester,
    ) async {
      final countdown = SeasonCountdown(
        days: 1,
        hours: 2,
        minutes: 3,
        seconds: 4,
        totalRemaining: const Duration(
          days: 1,
          hours: 2,
          minutes: 3,
          seconds: 4,
        ),
        status: CountdownStatus.active,
      );

      await tester.pumpWidget(
        wrap(SeasonCountdownWidget(countdown: countdown)),
      );

      expect(find.text('01'), findsOneWidget); // Days
      expect(find.text('02'), findsOneWidget); // Hours
      expect(find.text('D'), findsOneWidget);
    });

    testWidgets('SeasonHeader should render season name and status', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrap(SeasonPreviews.active()));
      await tester.pump();

      expect(find.text('CYBER SENTINEL'), findsOneWidget);
      expect(find.text('ACTIVE'), findsOneWidget);
    });

    testWidgets('SeasonHeader should show ENDING SOON when in ending state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrap(SeasonPreviews.endingSoon()));
      await tester.pump();

      expect(find.text('ENDING SOON'), findsOneWidget);
    });
  });
}
