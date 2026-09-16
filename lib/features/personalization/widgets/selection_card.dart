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
        margin: EdgeInsets.only(bottom: 8.h),
        height: 74.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          color: isSelected
              ? SoteriaColors.gold.withValues(alpha: 0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? SoteriaColors.gold
                : Colors.black.withValues(alpha: 0.05),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EFFF),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: const Color(0xFF2E1A8A),
                    size: 20.w,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleMedium.copyWith(
                        fontSize: 14.sp,
                        color: const Color(0xFF2E1A8A),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.bodySmall.copyWith(
                          color: const Color(0xFF2E1A8A).withValues(alpha: 0.5),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Trailing Indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? SoteriaColors.gold
                      : const Color(0xFFF3EFFF),
                ),
                child: Icon(
                  isSelected ? Icons.check : Icons.chevron_right_rounded,
                  color: isSelected
                      ? Colors.black
                      : const Color(0xFF2E1A8A),
                  size: 16.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
