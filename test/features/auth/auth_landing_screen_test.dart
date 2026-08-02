import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/auth/screens/auth_landing_screen.dart';
import 'package:soteria/features/auth/widgets/auth_hero_section.dart';
import 'package:soteria/features/auth/widgets/feature_carousel.dart';

void main() {
  Widget createTestWidget({required Widget child}) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) => MaterialApp(home: child),
      ),
    );
  }

  group('AuthLandingScreen Widget Tests', () {
    testWidgets('renders hero section and buttons', (tester) async {
      tester.view.physicalSize = const Size(390, 1500); // High viewport
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(child: const AuthLandingScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AuthHeroSection), findsOneWidget);
      expect(find.text('Welcome to Soteria'), findsOneWidget);
      expect(find.text('Continue with Google'), findsOneWidget);
      expect(find.text('Continue with Email'), findsOneWidget);
    });

    testWidgets('renders feature carousel', (tester) async {
      tester.view.physicalSize = const Size(390, 1500);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(child: const AuthLandingScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FeatureCarousel), findsOneWidget);
    });

    testWidgets('guest mode shows coming soon', (tester) async {
      tester.view.physicalSize = const Size(390, 1500);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(child: const AuthLandingScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Continue as Guest (Coming Soon)'), findsOneWidget);
    });
  });
}
