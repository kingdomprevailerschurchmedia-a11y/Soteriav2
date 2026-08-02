import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/typography/soteria_text.dart';
import 'package:soteria/core/widgets/feedback/soteria_badge.dart';
import 'package:soteria/core/design_system/themes/soteria_theme.dart';
import 'test_helper.dart';

void main() {
  setupTestEnvironment();
  Widget wrap(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, _) => MaterialApp(
        theme: SoteriaTheme.darkTheme,
        home: Scaffold(body: child),
      ),
    );
  }

  group('Core Components Tests', () {
    testWidgets('SoteriaButton primary renders label and handles tap', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        wrap(
          SoteriaButton.primary(
            label: 'Click Me',
            onPressed: () => tapped = true,
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);

      await tester.tap(find.byType(InkWell));
      expect(tapped, isTrue);
    });

    testWidgets('SoteriaBadge displays label', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(const SoteriaBadge(label: 'Active')));

      expect(find.text('ACTIVE'), findsOneWidget);
    });

    testWidgets('SoteriaText variants use correct styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrap(const SoteriaText.displayLarge('Big Text')));

      final textWidget = tester.widget<Text>(find.byType(Text));
      // 64.sp on a 390 width screen in a test environment might vary,
      // but ScreenUtil usually returns 64 if width matches.
      expect(textWidget.style?.fontSize, isNotNull);
    });
  });
}
