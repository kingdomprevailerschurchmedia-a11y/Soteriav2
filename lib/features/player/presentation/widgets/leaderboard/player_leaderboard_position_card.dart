import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_text.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/player/domain/models/leaderboard_entry.dart';
import 'rank_movement_indicator.dart';

class PlayerLeaderboardPositionCard extends StatelessWidget {
  final LeaderboardEntry entry;
  final int totalPlayers;
  final int delta;

  const PlayerLeaderboardPositionCard({
    super.key,
    required this.entry,
    required this.totalPlayers,
    required this.delta,
  });

  @override
  Widget build(BuildContext context) {
    final percentile = (entry.position / totalPlayers) * 100;

    return Semantics(
      label: 'Your leaderboard position is ${entry.position}. '
             'Movement is ${delta == 0 ? 'unchanged' : delta > 0 ? 'up $delta' : 'down ${delta.abs()}'}. '
             'You have ${entry.rankPoints} rank points, which is the top ${percentile.toStringAsFixed(1)} percent.',
      child: SoteriaCard(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        hasGlow: true,
        glowColor: SoteriaColors.primary.withValues(alpha: 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SoteriaText.caption(
              'YOUR POSITION',
              color: Colors.white.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: SoteriaText.headline(
                          '#${entry.position}',
                          color: SoteriaColors.gold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: RankMovementIndicator(delta: delta),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SoteriaText.headline(
                        '${entry.rankPoints} RP',
                        color: Colors.white,
                      ),
                      SoteriaText.caption(
                        'Top ${percentile.toStringAsFixed(1)}%',
                        color: SoteriaColors.success,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
