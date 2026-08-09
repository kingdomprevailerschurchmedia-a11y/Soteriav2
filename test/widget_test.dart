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
import 'test_helper.dart';

void main() {
  setupTestEnvironment();

  testWidgets('App launch test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            firebaseInitFutureProvider.overrideWith((ref) async {}),
            identityRepositoryProvider.overrideWithValue(MockIdentityRepo()),
            authRepositoryProvider.overrideWithValue(MockAuthRepository()),
          ],
          child: const SoteriaApp(),
        ),
      );

      // Verify basic app structure is present (MaterialApp)
      expect(find.byType(SoteriaApp), findsOneWidget);
    });
  });
}
