import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/player/presentation/screens/leaderboard_screen.dart';
import 'package:soteria/features/player/preview/leaderboard_previews.dart';
import 'package:soteria/core/design_system/themes/soteria_theme.dart';
import 'package:soteria/features/player/presentation/widgets/leaderboard_podium.dart';

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

  group('Leaderboard UI', () {
    testWidgets('LeaderboardScreen should render podium and rows', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrap(LeaderboardPreviews.topList()));
      await tester.pumpAndSettle();

      expect(find.text('LEADERBOARD'), findsOneWidget);
      expect(find.byType(LeaderboardPodium), findsOneWidget);
      expect(find.text('#1'), findsOneWidget); // Podium #1
    });

    testWidgets('LeaderboardScreen should show empty state when no entries', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrap(LeaderboardPreviews.empty()));
      await tester.pumpAndSettle();

      expect(find.text('No data available'), findsOneWidget);
    });

    testWidgets('LeaderboardScreen should show sticky row for current user', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrap(LeaderboardPreviews.midRank()));
      await tester.pumpAndSettle();

      expect(find.text('Joseph Ade'), findsOneWidget);
    });
  });
}
