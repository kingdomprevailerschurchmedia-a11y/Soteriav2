import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/question_presentation/providers/presentation_providers.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.text,
    required this.onTap,
    this.visualState = AnswerVisualState.normal,
    this.prefix,
    this.mediaUrl,
  });

  final String text;
  final VoidCallback onTap;
  final AnswerVisualState visualState;
  final String? prefix; // e.g., 'A', 'B'
  final String? mediaUrl;

  @override
  Widget build(BuildContext context) {
    final isSelected = visualState == AnswerVisualState.selected;
    final isCorrect = visualState == AnswerVisualState.correct;
    final isWrong = visualState == AnswerVisualState.wrong;
    final isLocked =
        visualState == AnswerVisualState.locked ||
        visualState == AnswerVisualState.disabled;

    Color borderColor = Colors.white.withValues(alpha: 0.1);
    Color glowColor = Colors.transparent;
    double opacity = 0.08;

    if (isSelected) {
      borderColor = SoteriaColors.primary;
      glowColor = SoteriaColors.primary.withValues(alpha: 0.2);
      opacity = 0.15;
    } else if (isCorrect) {
      borderColor = SoteriaColors.success;
      glowColor = SoteriaColors.success.withValues(alpha: 0.2);
      opacity = 0.2;
    } else if (isWrong) {
      borderColor = SoteriaColors.error;
      glowColor = SoteriaColors.error.withValues(alpha: 0.2);
      opacity = 0.2;
    }

    return Semantics(
      button: true,
      selected: isSelected,
      enabled: !isLocked,
      label: 'Answer option: $text',
      child: Padding(
        padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
        child: GestureDetector(
          onTap: isLocked ? null : onTap,
          child: AnimatedContainer(
            duration: SoteriaAnimations.fast,
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: SoteriaRadius.brLg,
              boxShadow: [
                if (isSelected || isCorrect || isWrong)
                  BoxShadow(color: glowColor, blurRadius: 15, spreadRadius: -5),
              ],
            ),
            child: GlassSurface(
              borderRadius: SoteriaRadius.brLg,
              opacity: opacity,
              padding: EdgeInsets.all(SoteriaSpacing.lg),
              border: Border.all(color: borderColor, width: 1.5),
              child: Row(
                children: [
                  if (prefix != null) ...[
                    _AnswerPrefix(prefix: prefix!, visualState: visualState),
                    SizedBox(width: SoteriaSpacing.md),
                  ],
                  Expanded(
                    child: Text(
                      text,
                      style: context.bodyLarge.copyWith(
                        fontWeight: isSelected || isCorrect || isWrong
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isLocked && !isCorrect && !isWrong
                            ? SoteriaColors.muted
                            : SoteriaColors.textPrimary,
                      ),
                    ),
                  ),
                  if (isCorrect)
                    const Icon(
                      Icons.check_circle_rounded,
                      color: SoteriaColors.success,
                    ),
                  if (isWrong)
                    const Icon(
                      Icons.cancel_rounded,
                      color: SoteriaColors.error,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnswerPrefix extends StatelessWidget {
  const _AnswerPrefix({required this.prefix, required this.visualState});

  final String prefix;
  final AnswerVisualState visualState;

  @override
  Widget build(BuildContext context) {
    final isSelected = visualState == AnswerVisualState.selected;
    final isCorrect = visualState == AnswerVisualState.correct;
    final isWrong = visualState == AnswerVisualState.wrong;

    Color bgColor = Colors.white.withValues(alpha: 0.1);
    Color textColor = SoteriaColors.textSecondary;

    if (isSelected) {
      bgColor = SoteriaColors.primary;
      textColor = Colors.white;
    } else if (isCorrect) {
      bgColor = SoteriaColors.success;
      textColor = Colors.white;
    } else if (isWrong) {
      bgColor = SoteriaColors.error;
      textColor = Colors.white;
    }

    return AnimatedContainer(
      duration: SoteriaAnimations.fast,
      width: 32.w,
      height: 32.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Text(
        prefix,
        style: context.labelLarge.copyWith(
          color: textColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
