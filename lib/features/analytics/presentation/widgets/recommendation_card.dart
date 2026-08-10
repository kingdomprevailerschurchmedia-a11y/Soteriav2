import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';

class RecommendationCard extends StatelessWidget {
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onAction;

  const RecommendationCard({
    super.key,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: SoteriaColors.gold.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: SoteriaColors.gold.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: const BoxDecoration(
                  color: SoteriaColors.gold,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.psychology, color: SoteriaColors.background, size: 20.w),
              ),
              SizedBox(width: 12.w),
              Text(
                'Soteria Advice',
                style: SoteriaTypography.labelLarge.copyWith(color: SoteriaColors.gold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: SoteriaTypography.titleMedium.copyWith(color: SoteriaColors.textPrimary),
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            style: SoteriaTypography.bodyMedium.copyWith(color: SoteriaColors.textSecondary),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: SoteriaColors.gold,
                foregroundColor: SoteriaColors.background,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text(
                actionLabel,
                style: SoteriaTypography.labelLarge.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
