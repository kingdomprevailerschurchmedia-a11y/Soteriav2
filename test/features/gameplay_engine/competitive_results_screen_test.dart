import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/gameplay_engine/pages/competitive_results_screen.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';
import 'package:soteria/core/design_system/components/soteria_badge.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';

class MockUser implements auth.User {
  @override
  String get uid => 'user_123';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockAuthService implements IAuthService {
  @override
  auth.User? get currentUser => MockUser();

  @override
  auth.FirebaseAuth get instance => throw UnimplementedError();

  @override
  Stream<auth.User?> get authStateChanges => throw UnimplementedError();

  @override
  Future<void> signOut() async {}
}

void main() {
  testWidgets(
    'CompetitiveResultsScreen displays accuracy and badges correctly',
    (WidgetTester tester) async {
      // Set a large enough surface size for the test
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final result = MockDataFactory.createMockResult(isPerfect: true);
      final session = MockDataFactory.createMockCompetitiveSession();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            firebaseAuthServiceProvider.overrideWithValue(MockAuthService()),
          ],
          child: ScreenUtilInit(
            designSize: const Size(1080, 2400),
            builder: (context, child) => MaterialApp(
              home: CompetitiveResultsScreen(
                result: result,
                session: session,
                onPlayAgain: () {},
                onHome: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check Accuracy
      expect(find.text('100%'), findsOneWidget);
      expect(find.text('ACCURACY'), findsOneWidget);

      // Check Badge
      expect(find.widgetWithText(SoteriaBadge, 'MATCH WON'), findsOneWidget);

      // Check Statistics Cards
      expect(find.text('SESSION STATISTICS'), findsOneWidget);
      expect(find.text('REWARDS EARNED'), findsOneWidget);
      expect(find.text('COMPETITIVE SETTLEMENT'), findsOneWidget);
    },
  );
}
