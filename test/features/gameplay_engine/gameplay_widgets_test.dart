import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/gameplay_engine/widgets/gameplay_progress_bar.dart';

void main() {
  Widget createTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, _) => MaterialApp(home: Scaffold(body: child)),
    );
  }

  group('GameplayProgressBar Tests', () {
    testWidgets('renders progress correctly', (tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const GameplayProgressBar(progress: 0.5, current: 5, total: 10),
        ),
      );

      expect(find.text('Question 5 of 10'), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);

      final linearProgress = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(linearProgress.value, 0.5);
    });
  });
}
