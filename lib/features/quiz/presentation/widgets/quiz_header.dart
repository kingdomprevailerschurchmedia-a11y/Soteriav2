import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/animations/animated_numeric_counter.dart';

class QuizHeader extends StatelessWidget {
  const QuizHeader({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.score,
    required this.onExit,
  });

  final int currentQuestion;
  final int totalQuestions;
  final int score;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: onExit,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Column(
                children: [
                  Text(
                    'QUESTION',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    '$currentQuestion / $totalQuestions',
                    style: context.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              _buildScoreDisplay(context),
            ],
          ),
          SizedBox(height: SoteriaSpacing.lg),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildScoreDisplay(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: SoteriaColors.gold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.stars_rounded, color: SoteriaColors.gold, size: 18.sp),
          SizedBox(width: 6.w),
          AnimatedNumericCounter(
            value: score,
            style: context.titleSmall.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final double progress = totalQuestions > 0
        ? (currentQuestion / totalQuestions)
        : 0.0;

    return Stack(
      children: [
        Container(
          height: 6.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        FractionallySizedBox(
          widthFactor: progress.clamp(0.0, 1.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 6.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [SoteriaColors.primary, SoteriaColors.secondary],
              ),
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: SoteriaColors.primary.withValues(alpha: 0.5),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
