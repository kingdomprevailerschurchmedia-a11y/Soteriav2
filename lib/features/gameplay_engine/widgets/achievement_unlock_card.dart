import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';

class AchievementUnlockCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const AchievementUnlockCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      borderColor: SoteriaColors.gold.withValues(alpha: 0.3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(SoteriaSpacing.md),
            decoration: BoxDecoration(
              color: SoteriaColors.gold.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: SoteriaColors.gold, size: 24.sp),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ACHIEVEMENT UNLOCKED',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    fontWeight: FontWeight.w900,
                    fontSize: 10.sp,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  title,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
