import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_progress_bar.dart';

class SoteriaXPBar extends StatelessWidget {
  final int currentXP;
  final int nextLevelXP;
  final int level;

  const SoteriaXPBar({
    super.key,
    required this.currentXP,
    required this.nextLevelXP,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentXP / nextLevelXP;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'LEVEL $level',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.gold,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            Text(
              '$currentXP / $nextLevelXP XP',
              style: context.labelSmall.copyWith(color: SoteriaColors.muted),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.sm),
        SoteriaProgressBar(progress: progress, hasGlow: true),
      ],
    );
  }
}

class SoteriaCoinWidget extends StatelessWidget {
  final int amount;
  final double size;

  const SoteriaCoinWidget({super.key, required this.amount, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.monetization_on_rounded,
          color: SoteriaColors.gold,
          size: size.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          amount.toString(),
          style: TextStyle(
            color: SoteriaColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: (size * 0.8).sp,
          ),
        ),
      ],
    );
  }
}

class SoteriaLevelBadge extends StatelessWidget {
  final int level;
  final double size;

  const SoteriaLevelBadge({super.key, required this.level, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: SoteriaColors.primary.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: SoteriaColors.primary.withValues(alpha: 0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: Text(
          level.toString(),
          style: TextStyle(
            color: SoteriaColors.textPrimary,
            fontWeight: FontWeight.w900,
            fontSize: (size * 0.4).sp,
          ),
        ),
      ),
    );
  }
}

class SoteriaStreakWidget extends StatelessWidget {
  final int streak;

  const SoteriaStreakWidget({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: SoteriaRadius.brFull,
        border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            color: Colors.orange,
            size: 16,
          ),
          SizedBox(width: 4.w),
          Text(
            streak.toString(),
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
