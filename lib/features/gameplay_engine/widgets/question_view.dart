import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/gameplay_engine/widgets/game_glass_card.dart';

class QuestionView extends StatelessWidget {
  final Question question;
  final Function(String) onAnswerSelected;
  final String? selectedAnswerId;

  const QuestionView({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    this.selectedAnswerId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GameGlassCard(
          padding: EdgeInsets.all(SoteriaSpacing.xl),
          child: Text(
            question.text,
            style: context.titleLarge.copyWith(
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        ...question.options.map(
          (answer) => Padding(
            padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
            child: _AnswerOption(
              answer: answer,
              isSelected: selectedAnswerId == answer.id,
              onTap: () => onAnswerSelected(answer.id),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnswerOption extends StatelessWidget {
  final Answer answer;
  final bool isSelected;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.answer,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.lg,
          vertical: SoteriaSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? SoteriaColors.primary.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? SoteriaColors.primary
                : Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? SoteriaColors.primary
                      : SoteriaColors.muted,
                  width: 2,
                ),
                color: isSelected ? SoteriaColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 14.w, color: Colors.white)
                  : null,
            ),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(
              child: Text(
                answer.text,
                style: context.bodyLarge.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? Colors.white
                      : SoteriaColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
