import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/gameplay_engine/widgets/game_glass_card.dart';

class GameResultView extends StatelessWidget {
  final int score;
  final int xp;
  final String status;
  final VoidCallback onDone;

  const GameResultView({
    super.key,
    required this.score,
    required this.xp,
    required this.status,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SoteriaSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            status.toUpperCase(),
            style: context.displayMedium.copyWith(
              color: status == 'completed'
                  ? SoteriaColors.success
                  : SoteriaColors.error,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          GameGlassCard(
            child: Column(
              children: [
                _ResultRow(label: 'FINAL SCORE', value: score.toString()),
                const Divider(color: Colors.white10),
                _ResultRow(label: 'XP EARNED', value: '+$xp'),
              ],
            ),
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          ElevatedButton(onPressed: onDone, child: const Text('BACK TO MENU')),
        ],
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  const _ResultRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
          ),
          Text(
            value,
            style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
