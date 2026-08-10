import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/onboarding/screens/onboarding_screen.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_page.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_indicator.dart';

void main() {
  Widget createTestWidget({
    required Widget child,
    Size size = const Size(390, 844),
  }) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: size,
        builder: (context, _) => MaterialApp(home: child),
      ),
    );
  }

  group('OnboardingScreen Widget Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('renders first page correctly', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(child: const OnboardingScreen()),
      );
      await tester.pump();

      // Check for rich text "Compete." using widget predicate
      expect(
        find.byWidgetPredicate(
          (w) => w is RichText && w.text.toPlainText().contains('Compete.'),
        ),
        findsOneWidget,
      );
      expect(find.byType(OnboardingPage), findsOneWidget);
      expect(find.byType(OnboardingIndicator), findsOneWidget);
      expect(find.text('SKIP'), findsOneWidget);
      expect(find.text('NEXT'), findsOneWidget);
    });

    testWidgets('navigation updates UI', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(child: const OnboardingScreen()),
      );
      await tester.pump();

      // Tap Next
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();

      expect(find.text('Challenge Yourself'), findsOneWidget);
    });

    testWidgets('last page shows Start', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(child: const OnboardingScreen()),
      );
      await tester.pump();

      // Swipe to the last page (total 4 pages)
      final pageView = find.byType(PageView);
      await tester.drag(pageView, const Offset(-400, 0));
      await tester.pumpAndSettle();
      await tester.drag(pageView, const Offset(-400, 0));
      await tester.pumpAndSettle();
      await tester.drag(pageView, const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.text('Ready to Begin?'), findsOneWidget);
      expect(find.text('START'), findsOneWidget);
      expect(find.text('Sign In'), findsNothing);
      expect(find.text('Create Account'), findsNothing);
    });

    testWidgets('onboarding accessibility test', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(child: const OnboardingScreen()),
      );
      await tester.pump();

      // Verify label is present
      expect(find.bySemanticsLabel(RegExp('Next', caseSensitive: false)), findsOneWidget);
    });
  });
}
