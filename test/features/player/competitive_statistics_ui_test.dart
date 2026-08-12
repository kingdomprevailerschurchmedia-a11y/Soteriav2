import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/player/presentation/providers/statistics_providers.dart';
import 'package:soteria/features/player/presentation/screens/competitive_statistics_screen.dart';
import 'package:soteria/features/player/preview/statistics_previews.dart';

void main() {
  Widget createTestWidget({
    bool isLoading = false,
    Object? error,
    bool isEmpty = false,
  }) {
    return ProviderScope(
      overrides: [
        competitiveStatisticsProvider.overrideWithValue(
          isLoading
              ? const AsyncValue.loading()
              : error != null
              ? AsyncValue.error(error, StackTrace.current)
              : AsyncValue.data(
                  isEmpty
                      ? StatisticsPreviews.emptyStats()
                      : StatisticsPreviews.fullStats(),
                ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) =>
            const MaterialApp(home: CompetitiveStatisticsScreen()),
      ),
    );
  }

  testWidgets('should show loading indicator', (tester) async {
    await tester.pumpWidget(createTestWidget(isLoading: true));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show career metrics', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('67.9%'), findsOneWidget); // Win rate
    expect(
      find.text('872'),
      findsOneWidget,
    ); // Wins in WinRateCard (Wait, WinRateCard shows wins/losses)
    expect(find.text('CAREER OVERVIEW'), findsOneWidget);
    expect(find.text('PERFORMANCE METRICS'), findsOneWidget);
  });

  testWidgets('should show trends and insights', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    final trendsSection = find.text('PERFORMANCE TRENDS');
    await tester.scrollUntilVisible(
      trendsSection,
      500,
      scrollable: find.byType(Scrollable).first,
    );
    expect(trendsSection, findsOneWidget);

    final insightText = find.text('Win rate improved');
    await tester.scrollUntilVisible(
      insightText,
      500,
      scrollable: find.byType(Scrollable).first,
    );
    expect(insightText, findsOneWidget);
  });

  testWidgets('should show error state', (tester) async {
    await tester.pumpWidget(createTestWidget(error: 'Failed to load'));
    await tester.pumpAndSettle();

    expect(find.text('Statistics Unavailable'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}
