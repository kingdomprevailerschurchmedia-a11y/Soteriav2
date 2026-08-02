import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';

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
    return Stack(
      alignment: Alignment.center,
      children: [
        // Ambient glow behind the question card
        const Positioned(
          top: -20,
          child: AmbientGlow(
            color: SoteriaColors.primary,
            size: 150,
            opacity: 0.1,
          ),
        ),
        GlassSurface(
          borderRadius: SoteriaRadius.brXl,
          opacity: 0.05,
          padding: EdgeInsets.all(SoteriaSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (category != null || difficulty != null)
                Padding(
                  padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (category != null)
                        _Tag(
                          label: category!.toUpperCase(),
                          color: SoteriaColors.gold,
                        ),
                      if (category != null && difficulty != null)
                        SizedBox(width: SoteriaSpacing.sm),
                      if (difficulty != null)
                        _Tag(
                          label: difficulty!.toUpperCase(),
                          color: SoteriaColors.primary,
                        ),
                    ],
                  ),
                ),
              Text(
                text,
                style: context.displayMedium.copyWith(
                  fontSize: 24.sp,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              if (mediaUrl != null) ...[
                SizedBox(height: SoteriaSpacing.xl),
                // Placeholder for future media implementation
                Container(
                  height: 200.h,
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
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: SoteriaRadius.brFull,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Text(
        label,
        style: context.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 10.sp,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
