import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:soteria/features/dashboard/presentation/widgets/hero_card.dart';
import 'package:soteria/features/dashboard/presentation/widgets/dashboard_skeleton.dart';
import 'package:soteria/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:soteria/features/player/providers/player_providers.dart';

void main() {
  Widget wrap(Widget child, {List overrides = const []}) {
    return ProviderScope(
      overrides: overrides.cast(),
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) => MaterialApp(home: child),
      ),
    );
  }

  testWidgets('DashboardScreen shows skeleton when loading', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        const DashboardScreen(),
        overrides: [
          announcementsProvider.overrideWith((ref) => Future.value([])),
          dailyChallengeProvider.overrideWith((ref) => Future.value(null)),
          currentPlayerStreamProvider.overrideWith(
            (ref) => const Stream.empty(),
          ),
        ],
      ),
    );
    expect(find.byType(DashboardSkeleton), findsOneWidget);
  });

  testWidgets('HeroCard renders progression data correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        const Scaffold(
          body: HeroCard(
            level: 5,
            xpInCurrentLevel: 500,
            xpThreshold: 1000,
            coins: 100,
            rank: 'Scholar',
            progress: 0.5,
            xpRemaining: 500,
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
