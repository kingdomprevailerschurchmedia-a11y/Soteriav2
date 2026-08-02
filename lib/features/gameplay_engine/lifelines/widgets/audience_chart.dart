import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/glass_surface.dart';

class AudienceChart extends StatelessWidget {
  const AudienceChart({super.key, required this.votes});

  final Map<String, double> votes; // ID to percentage (0.0 - 1.0)

  @override
  Widget build(BuildContext context) {
    final entries = votes.entries.toList();

    return GlassSurface(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'AUDIENCE POLL',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: entries.asMap().entries.map((e) {
              final index = e.key;
              final entry = e.value;
              return _Bar(
                label: String.fromCharCode(65 + index),
                value: entry.value,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.label, required this.value});
  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${(value * 100).toInt()}%',
          style: context.labelSmall.copyWith(
            fontSize: 10.sp,
            color: SoteriaColors.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          width: 24.w,
          height: 100.h * value,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [SoteriaColors.primary, SoteriaColors.secondary],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: context.labelLarge.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
