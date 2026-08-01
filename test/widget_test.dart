import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/core/app/app.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'test_helper.dart';

void main() {
  setupTestEnvironment();

  testWidgets('App launch test - verify splash screen content', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.runAsync(() async {
      await tester.pumpWidget(
        const ProviderScope(
          child: SoteriaApp(),
        ),
      );

      expect(find.byType(SoteriaLoader), findsOneWidget);
      expect(find.byIcon(Icons.shield_rounded), findsOneWidget);
    });
  });
}
