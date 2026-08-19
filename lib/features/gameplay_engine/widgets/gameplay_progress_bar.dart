import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_progress_bar.dart';

class GameplayProgressBar extends StatelessWidget {
  final double progress;
  final int current;
  final int total;

  const GameplayProgressBar({
    super.key,
    required this.progress,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Progress: $current of $total questions completed',
      value: '${(progress * 100).toInt()}%',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'QUESTION $current OF $total',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.textSecondary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  fontSize: 10.sp,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.sm),
          SoteriaProgressBar(
            progress: progress,
            height: 4.5,
            color: SoteriaColors.secondary,
            hasGlow: true,
          ),
        ],
      ),
    );
  }
}
