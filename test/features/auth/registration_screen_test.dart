import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/auth/screens/registration_screen.dart';
import 'package:soteria/features/auth/widgets/step_personal_identity.dart';
import 'package:soteria/features/auth/widgets/step_account_identity.dart';

void main() {
  Widget createTestWidget({required Widget child}) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) => MaterialApp(home: child),
      ),
    );
  }

  group('RegistrationScreen Widget Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('renders first step and transitions to second', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestWidget(child: const RegistrationScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(StepPersonalIdentity), findsOneWidget);
      expect(find.text('First Name'), findsOneWidget);

      // Fill personal info
      await tester.enterText(find.byType(TextField).at(0), 'John');
      await tester.enterText(find.byType(TextField).at(1), 'Doe');
      await tester.pump();

      // Tap continue
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.byType(StepAccountIdentity), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
    });
  });
}
