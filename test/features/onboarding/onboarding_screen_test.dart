import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/onboarding/screens/onboarding_screen.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_page.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_indicator.dart';

void main() {
  Widget createTestWidget({required Widget child, Size size = const Size(390, 844)}) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: size,
        builder: (context, _) => MaterialApp(
          home: child,
        ),
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
        createTestWidget(
          child: const OnboardingScreen(),
        ),
      );
      await tester.pump();

      expect(find.text('Compete. Learn. Rise.'), findsOneWidget);
      expect(find.byType(OnboardingPage), findsOneWidget);
      expect(find.byType(OnboardingIndicator), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('navigation updates UI', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(
          child: const OnboardingScreen(),
        ),
      );
      await tester.pump();

      // Tap Next
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Challenge Yourself'), findsOneWidget);
    });

    testWidgets('last page shows Get Started', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(
          child: const OnboardingScreen(),
        ),
      );
      await tester.pump();

      // Swipe to the last page (total 4 pages)
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.text('Ready to Begin?'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Create Account'), findsOneWidget);
    });

    testWidgets('onboarding accessibility test', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(
          child: const OnboardingScreen(),
        ),
      );
      await tester.pump();

      // Verify label is present
      expect(find.bySemanticsLabel('Next'), findsOneWidget);
    });
  });
}
