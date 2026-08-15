import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../../core/widgets/glass_surface.dart';
import '../../../../../gameplay_engine/models/pro_mode_config.dart';
import '../../../providers/pro_lobby_providers.dart';

class ProSessionSummaryCard extends ConsumerWidget {
  const ProSessionSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview = ref.watch(rewardPreviewProvider);
    final riskLevel = ref.watch(riskCalculatorProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _getRiskColor(riskLevel).withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: -8,
          ),
        ],
      ),
      child: GlassSurface(
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.lg,
          vertical: SoteriaSpacing.md,
        ),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'PRO CHALLENGE SUMMARY',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w900,
                    fontSize: 9,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: SoteriaColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${preview['multiplier']}X',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: 8,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SummaryItem(
                  label: 'XP',
                  value: '+${preview['potentialXP']}',
                  icon: Icons.bolt_rounded,
                  color: SoteriaColors.xpColor,
                ),
                _SummaryItem(
                  label: 'Win Cap',
                  value: '${preview['potentialCoins']}',
                  icon: Icons.monetization_on_rounded,
                  color: SoteriaColors.gold,
                ),
                _SummaryItem(
                  label: 'Risk',
                  value: riskLevel.label.toUpperCase(),
                  icon: Icons.warning_amber_rounded,
                  color: _getRiskColor(riskLevel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getRiskColor(RiskLevel level) {
    switch (level) {
      case RiskLevel.low:
        return SoteriaColors.success;
      case RiskLevel.medium:
        return SoteriaColors.gold;
      case RiskLevel.high:
        return Colors.orange;
      case RiskLevel.extreme:
        return SoteriaColors.error;
    }
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(height: 4),
        Text(
          value,
          style: context.bodyMedium.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
        Text(
          label.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
