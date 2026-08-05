import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/app/app.dart';
import 'package:soteria/core/navigation/app_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
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

  testWidgets('Navigation: Splash is the initial route', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.runAsync(() async {
      final container = ProviderContainer(
        overrides: [
          identityRepositoryProvider.overrideWithValue(MockIdentityRepo()),
          // Keep lifecycle at loading to stay on splash
          appLifecycleProvider.overrideWith(_MockAppLifecycleNotifier.new),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const SoteriaApp(),
        ),
      );

      final router = container.read(routerProvider);
      final routeMatchList = router.routerDelegate.currentConfiguration;
      expect(routeMatchList.uri.toString(), SoteriaRoutes.splash);
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

      final router = container.read(routerProvider);
      // Manually navigate to a bad route
      router.go('/bad-route');

      await tester.pump();
      // Wait for router
      await Future.delayed(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(find.byType(UnknownRouteScreen), findsOneWidget);
    });
  });
}
