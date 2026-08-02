import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/integrity/providers/integrity_providers.dart';
import 'package:soteria/features/gameplay_engine/integrity/models/risk_assessment.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class RiskInspector extends ConsumerWidget {
  const RiskInspector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kReleaseMode) return const SizedBox.shrink();

    final assessment = ref.watch(integrityProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SoteriaColors.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getColorForRisk(assessment.level), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RISK: ${assessment.level.name.toUpperCase()}',
                style: SoteriaTypography.label.copyWith(
                  color: _getColorForRisk(assessment.level),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'SCORE: ${assessment.score.toStringAsFixed(2)}',
                style: SoteriaTypography.caption,
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (assessment.score / 10.0).clamp(0.0, 1.0),
            backgroundColor: Colors.white10,
            color: _getColorForRisk(assessment.level),
          ),
          const SizedBox(height: 8),
          Text(
            'Signals Captured: ${assessment.signalCount}',
            style: SoteriaTypography.caption.copyWith(
              color: SoteriaColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForRisk(RiskLevel level) {
    switch (level) {
      case RiskLevel.low:
        return SoteriaColors.success;
      case RiskLevel.moderate:
        return SoteriaColors.gold;
      case RiskLevel.high:
        return Colors.orange;
      case RiskLevel.critical:
        return SoteriaColors.error;
    }
  }
}
