import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';

class PremiumStatisticCard extends StatelessWidget {
  const PremiumStatisticCard({
    super.key,
    required this.title,
    required this.value,
    this.unit = '',
    required this.icon,
    required this.color,
    this.trend,
  });

  final String title;
  final dynamic value;
  final String unit;
  final IconData icon;
  final Color color;
  final double? trend;

  @override
  Widget build(BuildContext context) {
    return GlassSurface(
      padding: EdgeInsets.all(SoteriaSpacing.sm),
      opacity: 0.04,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: SoteriaSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value.toString(),
                style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              if (unit.isNotEmpty)
                Text(
                  unit,
                  style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                ),
            ],
          ),
          Text(
            title.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              fontSize: 8,
              letterSpacing: 1,
            ),
          ),
          if (trend != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  trend! >= 0 ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                  color: trend! >= 0 ? SoteriaColors.success : SoteriaColors.error,
                  size: 12,
                ),
                Text(
                  ' ${(trend! * 100).abs().toInt()}%',
                  style: context.labelSmall.copyWith(
                    color: trend! >= 0 ? SoteriaColors.success : SoteriaColors.error,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
