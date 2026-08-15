import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../../core/design_system/typography/soteria_typography.dart';

class CompetitiveBadge extends StatelessWidget {
  const CompetitiveBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: SoteriaColors.gold.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          color: SoteriaColors.gold.withValues(alpha: 0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: SoteriaColors.gold.withValues(alpha: 0.2),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.stars_rounded, color: SoteriaColors.gold, size: 12),
          SizedBox(width: 6.w),
          Text(
            'PRO MODE',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 9.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
