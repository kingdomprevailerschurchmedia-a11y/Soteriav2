import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/components/soteria_text.dart';

class RankMovementIndicator extends StatelessWidget {
  final int delta; // Previous - Current. Positive means moved UP.

  const RankMovementIndicator({super.key, required this.delta});

  @override
  Widget build(BuildContext context) {
    if (delta == 0) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.remove, color: SoteriaColors.muted, size: 14),
          const SizedBox(width: 2),
          SoteriaText.caption('--', color: SoteriaColors.muted),
        ],
      );
    }

    final isUp = delta > 0;
    final color = isUp ? SoteriaColors.success : SoteriaColors.error;
    final icon = isUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 2),
        SoteriaText.caption(
          delta.abs().toString(),
          color: color,
        ),
      ],
    );
  }
}
