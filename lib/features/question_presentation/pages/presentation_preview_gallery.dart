import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_presentation/widgets/question_presenter.dart';
import 'package:soteria/features/question_presentation/providers/presentation_providers.dart';

class PresentationPreviewGallery extends StatelessWidget {
  const PresentationPreviewGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            context,
            'Standard Question (Multiple Choice)',
            _QuestionPreview(question: _mockQuestions[0]),
          ),
          _buildSection(
            context,
            'Correct Answer Reveal',
            _QuestionPreview(
              question: _mockQuestions[0],
              initialSelection: '1',
              revealResult: true,
            ),
          ),
          _buildSection(
            context,
            'Wrong Answer Reveal',
            _QuestionPreview(
              question: _mockQuestions[0],
              initialSelection: '2',
              revealResult: true,
            ),
          ),
          _buildSection(
            context,
            'True / False Question',
            _QuestionPreview(question: _mockQuestions[1]),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.labelLarge.copyWith(color: SoteriaColors.gold),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SizedBox(
          height: 600,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white10),
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: child,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xxl),
      ],
    );
  }
}

class _QuestionPreview extends ConsumerWidget {
  const _QuestionPreview({
    required this.question,
    this.initialSelection,
    this.revealResult = false,
  });

  final Question question;
  final String? initialSelection;
  final bool revealResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We wrap in a ProviderScope to isolate selection state for each preview item
    return ProviderScope(
      overrides: [
        if (initialSelection != null)
          answerSelectionProvider.overrideWith((ref) {
            final notifier = AnswerSelectionNotifier();
            notifier.select(initialSelection!);
            return notifier;
          }),
        isResultRevealedProvider.overrideWith((ref) => revealResult),
      ],
      child: QuestionPresenter(
        question: question,
        currentQuestionIndex: 0,
        totalQuestions: 10,
        sessionId: 'preview_session',
      ),
    );
  }
}

final List<Question> _mockQuestions = [
  Question(
    id: '1',
    version: '1.0',
    text:
        'Which architectural pattern does Soteria use for its Core Gameplay Engine?',
    difficulty: QuestionDifficulty.hard,
    category: 'Architecture',
    type: QuestionType.multipleChoice,
    options: [
      const Answer(id: '1', text: 'Clean Architecture'),
      const Answer(id: '2', text: 'MVC (Model-View-Controller)'),
      const Answer(id: '3', text: 'Monolithic Structure'),
      const Answer(id: '4', text: 'Hexagonal Architecture'),
    ],
    correctAnswers: ['1'],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    source: 'Soteria internal',
    schemaVersion: 1,
    contentHash: 'hash',
  ),
  Question(
    id: '2',
    version: '1.0',
    text: 'Soteria Design Language v2.1 supports only Dark Theme.',
    difficulty: QuestionDifficulty.easy,
    category: 'Design',
    type: QuestionType.trueFalse,
    options: [
      const Answer(id: '1', text: 'True'),
      const Answer(id: '2', text: 'False'),
    ],
    correctAnswers: ['1'],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    source: 'Soteria internal',
    schemaVersion: 1,
    contentHash: 'hash',
  ),
];
