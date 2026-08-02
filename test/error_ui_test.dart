import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/widgets/errors/error_screens.dart';
import 'package:soteria/core/errors/soteria_exception.dart';

void main() {
  Widget createWidgetUnderTest(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, _) => MaterialApp(home: child),
    );
  }

  testWidgets('PremiumErrorScreen displays network error details', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      createWidgetUnderTest(
        const PremiumErrorScreen(exception: NetworkException()),
      ),
    );

    expect(find.text('CONNECTION INTERRUPTED'), findsOneWidget);
    expect(find.byIcon(Icons.wifi_off_rounded), findsOneWidget);
  });

  testWidgets(
    'PremiumErrorScreen displays system anomaly for unexpected errors',
    (tester) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createWidgetUnderTest(
          const PremiumErrorScreen(
            exception: UnexpectedException(),
            isUnexpected: true,
          ),
        ),
      );

      expect(find.text('SYSTEM ANOMALY'), findsOneWidget);
      expect(find.textContaining('ERROR_CODE:'), findsOneWidget);
    },
  );

  testWidgets(
    'PremiumErrorScreen shows retry button when onRetry is provided',
    (tester) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      bool retried = false;
      await tester.pumpWidget(
        createWidgetUnderTest(
          PremiumErrorScreen(
            exception: const NetworkException(),
            onRetry: () => retried = true,
          ),
        ),
      );

      final retryButton = find.text('RE-ESTABLISH CONNECTION');
      expect(retryButton, findsOneWidget);

      await tester.tap(retryButton);
      expect(retried, true);
    },
  );
}
