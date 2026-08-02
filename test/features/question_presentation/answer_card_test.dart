import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/question_presentation/widgets/answer_card.dart';
import 'package:soteria/features/question_presentation/providers/presentation_providers.dart';

void main() {
  Widget wrapInMaterial(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, _) => MaterialApp(home: Scaffold(body: child)),
    );
  }

  group('AnswerCard Tests', () {
    testWidgets('renders answer text', (tester) async {
      await tester.pumpWidget(
        wrapInMaterial(AnswerCard(text: 'Test Answer', onTap: () {})),
      );

      expect(find.text('Test Answer'), findsOneWidget);
    });

    testWidgets('calls onTap when pressed', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        wrapInMaterial(
          AnswerCard(text: 'Test Answer', onTap: () => pressed = true),
        ),
      );

      await tester.tap(find.text('Test Answer'));
      expect(pressed, isTrue);
    });

    testWidgets('does not call onTap when locked', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        wrapInMaterial(
          AnswerCard(
            text: 'Test Answer',
            onTap: () => pressed = true,
            visualState: AnswerVisualState.locked,
          ),
        ),
      );

      await tester.tap(find.text('Test Answer'));
      expect(pressed, isFalse);
    });

    testWidgets('displays prefix when provided', (tester) async {
      await tester.pumpWidget(
        wrapInMaterial(
          AnswerCard(text: 'Test Answer', onTap: () {}, prefix: 'A'),
        ),
      );

      expect(find.text('A'), findsOneWidget);
    });
  });
}
