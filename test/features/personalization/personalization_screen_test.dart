import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/personalization/screens/personalization_screen.dart';
import 'package:soteria/features/personalization/widgets/selection_card.dart';

void main() {
  Widget createTestWidget({required Widget child}) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) => MaterialApp(home: child),
      ),
    );
  }

  group('PersonalizationScreen Widget Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('renders first step correctly', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(child: const PersonalizationScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('What is your current academic level?'), findsOneWidget);
      expect(find.byType(SelectionCard), findsAtLeastNWidgets(3));
    });

    testWidgets('navigation is blocked by validation', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(child: const PersonalizationScreen()),
      );
      await tester.pumpAndSettle();

      // Tap continue without selection
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Should still be on first step
      expect(find.text('What is your current academic level?'), findsOneWidget);
    });

    testWidgets('completes flow after selections', (tester) async {
      tester.view.physicalSize = const Size(
        390,
        1500,
      ); // Larger height to avoid scrolling
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(child: const PersonalizationScreen()),
      );
      await tester.pumpAndSettle();

      // Step 1: Academic Level
      await tester.tap(find.text('University'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Step 2: Interests
      expect(find.text('Select your interests'), findsOneWidget);
      await tester.tap(find.text('Technology'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Step 3: Goals
      expect(find.text('What are your goals?'), findsOneWidget);
      await tester.tap(find.text('Practice Daily'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Step 4: Notifications
      expect(find.text('Notification Preferences'), findsOneWidget);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Step 5: Summary
      expect(find.text('Review your profile'), findsOneWidget);
      expect(find.text('Complete Profile'), findsOneWidget);
    });
  });
}
