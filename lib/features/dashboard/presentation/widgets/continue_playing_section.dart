import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_progress_bar.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';

class ContinuePlayingSection extends StatelessWidget {
  const ContinuePlayingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CONTINUE PLAYING',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w800,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: SoteriaSpacing.md),
          SoteriaCard(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            borderRadius: SoteriaRadius.xxl,
            child: Row(
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        SoteriaColors.primary.withValues(alpha: 0.2),
                        SoteriaColors.secondary.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: SoteriaColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_circle_filled_rounded,
                      color: SoteriaColors.primary,
                      size: 48.sp,
                    ),
                  ),
                ),
                SizedBox(width: SoteriaSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Practice Mode',
                        style: context.titleMedium.copyWith(
                          fontWeight: FontWeight.w900,
                          color: SoteriaColors.textPrimary,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        '~ 3 mins remaining',
                        style: context.labelSmall.copyWith(
                          color: SoteriaColors.muted,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      const SoteriaProgressBar(progress: 0.65, hasGlow: true),
                    ],
                  ),
                ),
                SizedBox(width: SoteriaSpacing.lg),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: SoteriaColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: SoteriaColors.primary.withValues(alpha: 0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
