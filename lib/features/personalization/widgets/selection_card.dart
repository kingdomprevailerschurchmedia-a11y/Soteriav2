import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
    required this.icon,
  });

  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected
                ? SoteriaColors.gold.withValues(alpha: 0.8)
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: SoteriaColors.gold.withValues(alpha: 0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: GlassSurface(
          borderRadius: BorderRadius.circular(24.r),
          opacity: 0.05,
          blur: 10,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: isSelected ? SoteriaColors.gold : SoteriaColors.primary,
                      size: 28.w,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: context.titleMedium.copyWith(
                          fontSize: 18.sp,
                          color: isSelected ? SoteriaColors.gold : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          subtitle!,
                          style: context.bodySmall.copyWith(
                            color: SoteriaColors.textSecondary.withValues(alpha: 0.7),
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Trailing Icon
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? SoteriaColors.gold
                        : Colors.white.withValues(alpha: 0.05),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Icon(
                    isSelected ? Icons.check : Icons.chevron_right_rounded,
                    color: isSelected ? Colors.black : Colors.white.withValues(alpha: 0.5),
                    size: 20.w,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
