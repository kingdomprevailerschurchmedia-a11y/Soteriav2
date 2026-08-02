import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/gameplay_engine/widgets/game_glass_card.dart';

class AnswerPreviewGallery extends StatelessWidget {
  const AnswerPreviewGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            context,
            'Decision Outcomes',
            Column(
              children: [
                _ResultPreviewItem(
                  label: 'Correct Answer',
                  result: AnswerResult(
                    submissionId: '1',
                    questionId: 'q1',
                    decision: AnswerDecision.correct,
                    correctOptionIds: ['a'],
                    xpEarned: 15,
                    timestamp: DateTime.now(),
                  ),
                ),
                _ResultPreviewItem(
                  label: 'Wrong Answer',
                  result: AnswerResult(
                    submissionId: '2',
                    questionId: 'q1',
                    decision: AnswerDecision.wrong,
                    correctOptionIds: ['a'],
                    timestamp: DateTime.now(),
                  ),
                ),
                _ResultPreviewItem(
                  label: 'Timeout',
                  result: AnswerResult(
                    submissionId: '3',
                    questionId: 'q1',
                    decision: AnswerDecision.timeout,
                    correctOptionIds: ['a'],
                    timestamp: DateTime.now(),
                  ),
                ),
              ],
            ),
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
        SizedBox(height: SoteriaSpacing.xl),
        child,
        SizedBox(height: SoteriaSpacing.xxl),
      ],
    );
  }
}

class _ResultPreviewItem extends StatelessWidget {
  const _ResultPreviewItem({required this.label, required this.result});
  final String label;
  final AnswerResult result;

  @override
  Widget build(BuildContext context) {
    Color color = SoteriaColors.primary;
    IconData icon = Icons.info_outline;

    switch (result.decision) {
      case AnswerDecision.correct:
        color = SoteriaColors.success;
        icon = Icons.check_circle_rounded;
        break;
      case AnswerDecision.wrong:
        color = SoteriaColors.error;
        icon = Icons.cancel_rounded;
        break;
      case AnswerDecision.timeout:
        color = Colors.orange;
        icon = Icons.timer_off_rounded;
        break;
      default:
        break;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: GameGlassCard(
        borderColor: color.withValues(alpha: 0.3),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                    ),
                  ),
                  Text(
                    result.decision.name.toUpperCase(),
                    style: context.titleLarge.copyWith(
                      color: color,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (result.xpEarned > 0)
                    Text(
                      '+${result.xpEarned} XP EARNED',
                      style: context.bodySmall.copyWith(
                        color: SoteriaColors.gold,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
