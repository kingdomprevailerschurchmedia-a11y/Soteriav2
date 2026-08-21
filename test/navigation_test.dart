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
import 'package:soteria/features/error_routing/unknown_route_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'test_helper.dart';

class MockAppLifecycleNotifier extends AppLifecycleNotifier {
  @override
  AppStartupState build() => AppStartupState.ready;
}

class _MockAppLifecycleNotifier extends AppLifecycleNotifier {
  @override
  AppStartupState build() => AppStartupState.loading;
}

void main() {
  setupTestEnvironment();

  testWidgets('Navigation: App launches to main route', (
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
          appLifecycleProvider.overrideWith(MockAppLifecycleNotifier.new),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const SoteriaApp(),
        ),
      );

      // Settle initial router state
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      final router = container.read(routerProvider);
      final location = router.routerDelegate.currentConfiguration.uri
          .toString();

      expect(
        location.startsWith(SoteriaRoutes.main),
        isTrue,
        reason: 'Location was: $location',
      );
    });
  });

  testWidgets('Navigation: Unknown route shows UnknownRouteScreen', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.runAsync(() async {
      tester.view.physicalSize = const Size(390, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final container = ProviderContainer(
        overrides: [
          firebaseInitFutureProvider.overrideWith((ref) async {}),
          authRepositoryProvider.overrideWithValue(MockAuthRepository()),
          authCoordinatorProvider.overrideWithValue(MockAuthCoordinator()),
          notificationCoordinatorProvider.overrideWithValue(
            MockNotificationCoordinator(),
          ),
          configurationCoordinatorProvider.overrideWithValue(
            MockConfigurationCoordinator(),
          ),
          appLifecycleProvider.overrideWith(MockAppLifecycleNotifier.new),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const SoteriaApp(),
        ),
      );

      await tester.pumpAndSettle();

      final router = container.read(routerProvider);
      router.go('/bad-route');

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(find.byType(UnknownRouteScreen), findsOneWidget);
    });
  });
}
