import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/app/app.dart';
import 'package:soteria/core/navigation/app_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/firebase/providers/bootstrapper_provider.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/auth/services/auth_coordinator.dart';
import 'package:soteria/features/notifications/providers/notification_providers.dart';
import 'package:soteria/core/firebase/config/providers/configuration_providers.dart';
import 'package:soteria/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:soteria/features/splash/presentation/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../test_helper.dart';

class MockLoadingLifecycleNotifier extends AppLifecycleNotifier {
  @override
  AppStartupState build() => AppStartupState.loading;
}

void main() {
  setupTestEnvironment();

  testWidgets('Startup: Dashboard is NOT built during loading state', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.runAsync(() async {
      final container = ProviderContainer(
        overrides: [
          firebaseInitFutureProvider.overrideWith((ref) async {}),
          identityRepositoryProvider.overrideWithValue(MockIdentityRepo()),
          authRepositoryProvider.overrideWithValue(MockAuthRepository()),
          authCoordinatorProvider.overrideWithValue(MockAuthCoordinator()),
          notificationCoordinatorProvider.overrideWithValue(
            MockNotificationCoordinator(),
          ),
          configurationCoordinatorProvider.overrideWithValue(
            MockConfigurationCoordinator(),
          ),
          appLifecycleProvider.overrideWith(MockLoadingLifecycleNotifier.new),
        ],
      );
      addTearDown(container.dispose);

      // Force GoRouter to start at '/app' (which would normally flash Dashboard)
      // We do this by overriding the router provider with a custom initial location
      // or by relying on the redirect which we just fixed.
      
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const SoteriaApp(),
        ),
      );

      // Settle initial router state
      await tester.pump();
      
      // Attempt to navigate to Dashboard explicitly
      container.read(routerProvider).go(SoteriaRoutes.main);
      await tester.pump();

      // Verify that even after attempting to go to /app, we are gated.
      // DashboardScreen should NOT be in the tree.
      expect(find.byType(DashboardScreen), findsNothing);
      
      // SplashScreen SHOULD be in the tree.
      expect(find.byType(SplashScreen), findsOneWidget);
      
      // Clean up timers from SplashScreen
      await tester.pump(const Duration(milliseconds: 2000));
      await tester.pumpAndSettle();
    });
  });
}
