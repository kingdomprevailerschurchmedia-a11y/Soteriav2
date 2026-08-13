import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/player/domain/models/competitive_title.dart';

class CompetitiveTitleWidget extends StatelessWidget {
  final CompetitiveTitle? title;
  final bool isLarge;

  const CompetitiveTitleWidget({
    super.key,
    this.title,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    if (title == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? SoteriaSpacing.md : SoteriaSpacing.sm,
        vertical: isLarge ? 4.h : 2.h,
      ),
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: SoteriaColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        title!.name.toUpperCase(),
        style: context.labelSmall.copyWith(
          color: SoteriaColors.secondary,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          fontSize: isLarge ? 12.sp : 9.sp,
        ),
      ),
    );
  }
}
