import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/player/domain/models/competitive_profile.dart';
import 'package:soteria/features/player/presentation/providers/competitive_profile_provider.dart';
import 'package:soteria/features/player/presentation/screens/competitive_profile_screen.dart';
import 'package:soteria/features/player/preview/competitive_profile_previews.dart';

void main() {
  Widget createTestWidget({
    required CompetitiveProfile profile,
    bool isLoading = false,
    Object? error,
  }) {
    return ProviderScope(
      overrides: [
        competitiveProfileProvider.overrideWithValue(
          isLoading
              ? const AsyncValue.loading()
              : error != null
              ? AsyncValue.error(error, StackTrace.current)
              : AsyncValue.data(profile),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) =>
            const MaterialApp(home: CompetitiveProfileScreen()),
      ),
    );
  }

  testWidgets('should show loading state', (tester) async {
    await tester.pumpWidget(
      createTestWidget(
        profile: CompetitiveProfilePreviews.rankedPlayer(),
        isLoading: true,
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error state', (tester) async {
    await tester.pumpWidget(
      createTestWidget(
        profile: CompetitiveProfilePreviews.rankedPlayer(),
        error: 'Failed',
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Profile Unavailable'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('should show profile content for ranked player', (tester) async {
    final profile = CompetitiveProfilePreviews.rankedPlayer();
    await tester.pumpWidget(createTestWidget(profile: profile));
    await tester.pumpAndSettle();

    expect(find.text('CompetitivePro'), findsOneWidget);
    expect(find.text('Level 42'), findsOneWidget);
    expect(find.text('#127 GLOBAL'), findsOneWidget);
    expect(find.text('DIAMOND II'), findsOneWidget);
    expect(find.text('2840 RP'), findsOneWidget);
  });

  testWidgets('should show empty states for unranked player', (tester) async {
    final profile = CompetitiveProfilePreviews.unrankedPlayer();
    await tester.pumpWidget(createTestWidget(profile: profile));
    await tester.pumpAndSettle();

    expect(find.text('NewChallenger'), findsOneWidget);
    expect(
      find.text('UNRANKED II'),
      findsOneWidget,
    ); // Based on mock progression
    expect(find.text('0 RP'), findsOneWidget);
    expect(find.text('No rewards earned yet.'), findsOneWidget);
  });
}
