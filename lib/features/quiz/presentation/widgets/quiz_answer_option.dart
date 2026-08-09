import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';

enum QuizAnswerState { defaultState, selected, correct, incorrect, disabled }

class QuizAnswerOption extends StatelessWidget {
  const QuizAnswerOption({
    super.key,
    required this.letter,
    required this.text,
    this.state = QuizAnswerState.defaultState,
    this.onTap,
  });

  final String letter;
  final String text;
  final QuizAnswerState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isInteractive = state == QuizAnswerState.defaultState;

    return Semantics(
      label: 'Option $letter: $text',
      button: true,
      enabled: isInteractive,
      selected:
          state == QuizAnswerState.selected || state == QuizAnswerState.correct,
      child: GestureDetector(
        onTap: () {
          if (isInteractive && onTap != null) {
            HapticFeedback.lightImpact();
            onTap!();
          }
        },
        child: AnimatedScale(
          scale: state == QuizAnswerState.selected ? 1.02 : 1.0,
          duration: SoteriaAnimations.fast,
          child: AnimatedContainer(
            duration: SoteriaAnimations.fast,
            margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
            padding: EdgeInsets.symmetric(
              horizontal: SoteriaSpacing.lg,
              vertical: SoteriaSpacing.md,
            ),
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(SoteriaRadius.lg),
              border: Border.all(
                color: _getBorderColor(),
                width: state == QuizAnswerState.defaultState ? 1 : 2,
              ),
              boxShadow: _getShadows(),
            ),
            child: Row(
              children: [
                _buildLetterCircle(context),
                SizedBox(width: SoteriaSpacing.lg),
                Expanded(
                  child: Text(
                    text,
                    style: context.bodyLarge.copyWith(
                      color: _getTextColor(),
                      fontWeight: state == QuizAnswerState.defaultState
                          ? FontWeight.w500
                          : FontWeight.bold,
                    ),
                  ),
                ),
                if (_getIcon() != null) ...[
                  SizedBox(width: SoteriaSpacing.md),
                  Icon(_getIcon(), color: _getIconColor(), size: 24.sp),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLetterCircle(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getLetterCircleColor(),
        border: Border.all(color: _getLetterCircleBorderColor(), width: 1.5),
      ),
      child: Center(
        child: Text(
          letter,
          style: context.titleMedium.copyWith(
            color: _getLetterTextColor(),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (state) {
      case QuizAnswerState.selected:
        return SoteriaColors.primary.withValues(alpha: 0.15);
      case QuizAnswerState.correct:
        return SoteriaColors.success.withValues(alpha: 0.15);
      case QuizAnswerState.incorrect:
        return SoteriaColors.error.withValues(alpha: 0.15);
      case QuizAnswerState.disabled:
        return Colors.white.withValues(alpha: 0.02);
      case QuizAnswerState.defaultState:
        return Colors.white.withValues(alpha: 0.05);
    }
  }

  Color _getBorderColor() {
    switch (state) {
      case QuizAnswerState.selected:
        return SoteriaColors.primary;
      case QuizAnswerState.correct:
        return SoteriaColors.success;
      case QuizAnswerState.incorrect:
        return SoteriaColors.error;
      case QuizAnswerState.disabled:
        return Colors.white.withValues(alpha: 0.05);
      case QuizAnswerState.defaultState:
        return Colors.white.withValues(alpha: 0.1);
    }
  }

  List<BoxShadow>? _getShadows() {
    if (state == QuizAnswerState.defaultState ||
        state == QuizAnswerState.disabled) {
      return null;
    }
    Color color;
    switch (state) {
      case QuizAnswerState.selected:
        color = SoteriaColors.primary;
        break;
      case QuizAnswerState.correct:
        color = SoteriaColors.success;
        break;
      case QuizAnswerState.incorrect:
        color = SoteriaColors.error;
        break;
      default:
        color = Colors.transparent;
    }
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.2),
        blurRadius: 15,
        spreadRadius: -5,
      ),
    ];
  }

  Color _getTextColor() {
    if (state == QuizAnswerState.disabled) return SoteriaColors.muted;
    return SoteriaColors.textPrimary;
  }

  Color _getLetterCircleColor() {
    switch (state) {
      case QuizAnswerState.selected:
        return SoteriaColors.primary;
      case QuizAnswerState.correct:
        return SoteriaColors.success;
      case QuizAnswerState.incorrect:
        return SoteriaColors.error;
      case QuizAnswerState.disabled:
        return Colors.transparent;
      case QuizAnswerState.defaultState:
        return Colors.transparent;
    }
  }

  Color _getLetterCircleBorderColor() {
    switch (state) {
      case QuizAnswerState.selected:
        return Colors.white.withValues(alpha: 0.2);
      case QuizAnswerState.correct:
        return Colors.white.withValues(alpha: 0.2);
      case QuizAnswerState.incorrect:
        return Colors.white.withValues(alpha: 0.2);
      case QuizAnswerState.disabled:
        return Colors.white.withValues(alpha: 0.05);
      case QuizAnswerState.defaultState:
        return Colors.white.withValues(alpha: 0.3);
    }
  }

  Color _getLetterTextColor() {
    if (state == QuizAnswerState.defaultState)
      return SoteriaColors.textSecondary;
    if (state == QuizAnswerState.disabled) return SoteriaColors.muted;
    return Colors.white;
  }

  IconData? _getIcon() {
    switch (state) {
      case QuizAnswerState.correct:
        return Icons.check_circle_rounded;
      case QuizAnswerState.incorrect:
        return Icons.cancel_rounded;
      default:
        return null;
    }
  }

  Color _getIconColor() {
    switch (state) {
      case QuizAnswerState.correct:
        return SoteriaColors.success;
      case QuizAnswerState.incorrect:
        return SoteriaColors.error;
      default:
        return Colors.transparent;
    }
  }
}
