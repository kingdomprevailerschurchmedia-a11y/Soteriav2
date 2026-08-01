import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/app/app.dart';
import 'package:soteria/core/navigation/app_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/features/error_routing/unknown_route_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'test_helper.dart';

void main() {
  setupTestEnvironment();

  testWidgets('Navigation: Splash is the initial route', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    
    await tester.runAsync(() async {
      await tester.pumpWidget(
        const ProviderScope(
          child: SoteriaApp(),
        ),
      );

      final routeMatchList = AppRouter.router.routerDelegate.currentConfiguration;
      expect(routeMatchList.uri.toString(), SoteriaRoutes.splash);
    });
  });

  testWidgets('Navigation: Unknown route shows UnknownRouteScreen', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    
    await tester.runAsync(() async {
      await tester.pumpWidget(
        const ProviderScope(
          child: SoteriaApp(),
        ),
      );

      // Manually navigate to a bad route
      AppRouter.router.go('/bad-route');
      
      await tester.pump();
      // Wait for router
      await Future.delayed(const Duration(milliseconds: 100));
      await tester.pump();
      
      expect(find.byType(UnknownRouteScreen), findsOneWidget);
    });
  });
}
