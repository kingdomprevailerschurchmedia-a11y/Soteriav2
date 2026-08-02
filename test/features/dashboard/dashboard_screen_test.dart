import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:soteria/features/dashboard/presentation/widgets/hero_card.dart';
import 'package:soteria/features/dashboard/presentation/widgets/dashboard_skeleton.dart';

void main() {
  Widget wrap(Widget child) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) => MaterialApp(home: child),
      ),
    );
  }

  testWidgets('DashboardScreen shows skeleton when loading', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(wrap(const DashboardScreen()));
    expect(find.byType(DashboardSkeleton), findsOneWidget);

    // Clear pending timers from mock repo
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('HeroCard renders progression data correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        const Scaffold(
          body: HeroCard(
            level: 5,
            xp: 500,
            totalXpRequired: 1000,
            coins: 100,
            rank: 'Scholar',
          ),
        ),
      ),
    );

    // Wait for entrance animations
    await tester.pumpAndSettle();

    expect(find.text('5'), findsOneWidget);
    expect(find.text('100'), findsOneWidget);
    expect(find.text('SCHOLAR'), findsOneWidget);
  });
}
