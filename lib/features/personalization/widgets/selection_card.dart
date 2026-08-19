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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF8A55FD).withValues(alpha: 0.15),
                    const Color(0xFFFF4081).withValues(alpha: 0.05),
                  ],
                )
              : null,
          border: Border.all(
            color: isSelected
                ? const Color(0xFF8A55FD).withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.08),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF8A55FD).withValues(alpha: 0.1),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: GlassSurface(
          borderRadius: BorderRadius.circular(20.r),
          opacity: isSelected ? 0.2 : 0.05,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? const Color(0xFF8A55FD).withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF8A55FD).withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 22.w,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: context.titleMedium.copyWith(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 2.h),
                        Text(
                          subtitle!,
                          style: context.bodySmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Trailing Indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFF8A55FD), Color(0xFFFF4081)],
                          )
                        : null,
                    color: isSelected ? null : Colors.white.withValues(alpha: 0.05),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Icon(
                    isSelected ? Icons.check : Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 18.w,
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
