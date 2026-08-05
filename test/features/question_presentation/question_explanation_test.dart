import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_presentation/widgets/question_explanation_view.dart';

void main() {
  final mockQuestion = Question(
    id: 'q1',
    version: '1',
    text: 'Test?',
    explanation: 'This is why it is correct.',
    difficulty: QuestionDifficulty.easy,
    category: 'C',
    type: QuestionType.multipleChoice,
    options: const [],
    correctAnswers: const [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    source: 'Ref 123',
    schemaVersion: 1,
    contentHash: 'H',
  );

  Widget createTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, __) => MaterialApp(home: Scaffold(body: child)),
    );
  }

  group('QuestionExplanationView Tests', () {
    testWidgets('renders explanation and reference', (tester) async {
      bool continued = false;
      await tester.pumpWidget(
        createTestableWidget(
          QuestionExplanationView(
            question: mockQuestion,
            onContinue: () => continued = true,
          ),
        ),
      );

      expect(find.text('EXPLANATION'), findsOneWidget);
      expect(find.text('This is why it is correct.'), findsOneWidget);
      expect(find.text('Reference: Ref 123'), findsOneWidget);

      await tester.tap(find.text('CONTINUE'));
      expect(continued, isTrue);
    });
  });
}
