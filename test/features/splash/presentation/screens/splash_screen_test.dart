import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/splash/presentation/screens/splash_screen.dart';
import 'package:soteria/features/splash/presentation/widgets/splash_branding.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import '../../../../test_helper.dart';

void main() {
  setUp(() {
    setupTestEnvironment();
  });

  Widget createSplashScreen({AppStartupState state = AppStartupState.loading}) {
    return ProviderScope(
      overrides: [
        appLifecycleProvider.overrideWith(() => MockAppLifecycleNotifier(initialState: state)),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => const MaterialApp(
          home: SplashScreen(),
        ),
      ),
    );
  }

  group('SplashScreen Widget Tests', () {
    testWidgets('renders splash background and branding', (tester) async {
      await tester.pumpWidget(createSplashScreen());
      
      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.byType(SplashBranding), findsOneWidget);
      expect(find.byType(Image), findsWidgets); // BG and Logo

      // Clean up pending timers
      await tester.pump(const Duration(milliseconds: 2000));
      await tester.pumpAndSettle();
    });

    testWidgets('renders SOTERIA text and tagline', (tester) async {
      await tester.pumpWidget(createSplashScreen());
      
      expect(find.text('SOTERIA'), findsOneWidget);
      expect(find.text('COMPETE. LEARN. RISE.'), findsOneWidget);

      // Clean up pending timers
      await tester.pump(const Duration(milliseconds: 2000));
      await tester.pumpAndSettle();
    });

    testWidgets('logo animation starts with scale 0.94', (tester) async {
      await tester.pumpWidget(createSplashScreen());
      
      final scaleTransition = tester.widget<ScaleTransition>(
        find.descendant(
          of: find.byType(SplashBranding),
          matching: find.byType(ScaleTransition),
        ).first,
      );
      
      expect(scaleTransition.scale.value, closeTo(0.94, 0.01));

      // Clean up pending timers
      await tester.pump(const Duration(milliseconds: 2000));
      await tester.pumpAndSettle();
    });
  });
}
