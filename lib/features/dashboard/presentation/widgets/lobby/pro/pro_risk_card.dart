import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../../core/design_system/components/soteria_card.dart';
import '../../../../../gameplay_engine/models/pro_mode_config.dart';
import '../../../providers/pro_lobby_providers.dart';

class ProRiskCard extends ConsumerWidget {
  const ProRiskCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riskLevel = ref.watch(riskCalculatorProvider);

    return SoteriaCard(
      borderColor: _getRiskColor(riskLevel).withValues(alpha: 0.3),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getRiskColor(riskLevel).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: _getRiskColor(riskLevel),
              size: 24,
            ),
          ),
          SizedBox(width: SoteriaSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RISK ASSESSMENT',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  riskLevel.label,
                  style: context.titleMedium.copyWith(
                    color: _getRiskColor(riskLevel),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          _RiskLevelIndicator(level: riskLevel),
        ],
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

class _RiskLevelIndicator extends StatelessWidget {
  final RiskLevel level;
  const _RiskLevelIndicator({required this.level});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(4, (index) {
        final isActive = index <= level.index;
        return Container(
          width: 8,
          height: 16,
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            color: isActive
                ? _getRiskColor(level)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
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
