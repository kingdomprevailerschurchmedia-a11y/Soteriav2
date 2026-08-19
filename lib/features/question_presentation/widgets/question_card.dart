import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';

import '../../../../core/utils/soteria_responsive.dart';

class QuestionContentCard extends StatelessWidget {
  const QuestionContentCard({
    super.key,
    required this.text,
    this.mediaUrl,
    this.category,
    this.difficulty,
  });

  final String text;
  final String? mediaUrl;
  final String? category;
  final String? difficulty;

  @override
  Widget build(BuildContext context) {
    final isShort = SoteriaResponsive.isShortScreen(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Ambient glow behind the question card
        Positioned(
          top: -20,
          child: AmbientGlow(
            color: SoteriaColors.secondary,
            size: 250,
            opacity: 0.08,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: SoteriaRadius.brXl,
            boxShadow: [
              BoxShadow(
                color: SoteriaColors.secondary.withValues(alpha: 0.1),
                blurRadius: 40,
                spreadRadius: -10,
              ),
            ],
          ),
          child: GlassSurface(
            borderRadius: SoteriaRadius.brXl,
            opacity: 0.12,
            padding: EdgeInsets.symmetric(
              horizontal: SoteriaSpacing.xl,
              vertical: SoteriaSpacing.lg,
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1.2,
            ),
            child: Semantics(
            label: 'Question: $text',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (category != null || difficulty != null)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: SoteriaSpacing.md,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (category != null)
                          _Tag(
                            label: category!.toUpperCase(),
                            color: SoteriaColors.gold,
                            icon: Icons.science_outlined,
                          ),
                        if (category != null && difficulty != null)
                          SizedBox(width: SoteriaSpacing.sm),
                        if (difficulty != null)
                          _Tag(
                            label: difficulty!.toUpperCase(),
                            color: SoteriaColors.secondary,
                            icon: Icons.bar_chart_rounded,
                          ),
                      ],
                    ),
                  ),
                // Center "?" icon
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        SoteriaColors.secondary.withValues(alpha: 0.3),
                        SoteriaColors.primary.withValues(alpha: 0.1),
                      ],
                    ),
                    border: Border.all(
                      color: SoteriaColors.secondary.withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: SoteriaColors.secondary.withValues(alpha: 0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '?',
                      style: context.displaySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SoteriaSpacing.lg),
                Text(
                  text,
                  style: context.titleLarge.copyWith(
                    fontSize: 20.sp,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (mediaUrl != null) ...[
                  SizedBox(
                    height: SoteriaSpacing.adaptive(
                      context,
                      SoteriaSpacing.lgStatic,
                    ),
                  ),
                  // Placeholder for future media implementation
                  Container(
                    height: isShort ? 120.h : 200.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: SoteriaRadius.brMd,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        color: SoteriaColors.muted,
                        size: 48,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color, this.icon});

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: color, size: 12.sp),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 10.sp,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
