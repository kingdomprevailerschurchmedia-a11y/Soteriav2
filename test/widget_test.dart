import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/core/app/app.dart';
import 'package:soteria/core/navigation/app_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/firebase/providers/bootstrapper_provider.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/splash/splash_screen.dart';
import 'test_helper.dart';

void main() {
  setupTestEnvironment();

  testWidgets('App launch test - verify splash screen content', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.runAsync(() async {
      final testRouter = GoRouter(
        initialLocation: SoteriaRoutes.splash,
        routes: [
          GoRoute(
            path: SoteriaRoutes.splash,
            builder: (context, state) => const SplashScreen(),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            firebaseInitFutureProvider.overrideWith((ref) async {}),
            identityRepositoryProvider.overrideWithValue(MockIdentityRepo()),
            authRepositoryProvider.overrideWithValue(MockAuthRepository()),
            routerProvider.overrideWithValue(testRouter),
          ],
          child: const SoteriaApp(),
        ),
      );

      // Verify splash screen branding
      expect(find.text('SOTERIA'), findsOneWidget);
      expect(find.text('COMPETE. LEARN. RISE.'), findsOneWidget);
    });
  });
}
