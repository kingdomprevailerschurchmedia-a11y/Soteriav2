import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';
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

  group('Foundation Widgets Tests', () {
    testWidgets('GlassSurface renders child and backdrop filter', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const GlassSurface(
            child: Text('Test Child'),
          ),
        ),
      );

      expect(find.text('Test Child'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('AmbientGlow renders with correct color', (WidgetTester tester) async {
      const testColor = Colors.red;
      await tester.pumpWidget(
        wrap(
          const AmbientGlow(color: testColor, size: 100),
        ),
      );

      // Find the specific container within AmbientGlow
      final containerFinder = find.descendant(
        of: find.byType(AmbientGlow),
        matching: find.byType(Container),
      ).first;

      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;
      
      expect(decoration.color?.withValues(alpha: 1.0), testColor.withValues(alpha: 1.0));
    });
  });
}
