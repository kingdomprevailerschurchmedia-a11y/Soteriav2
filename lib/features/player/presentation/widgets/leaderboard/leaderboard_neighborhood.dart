import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_text.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/player/domain/models/leaderboard_entry.dart';
import '../leaderboard_row.dart';

class LeaderboardNeighborhood extends StatelessWidget {
  final LeaderboardEntry? playerAbove;
  final LeaderboardEntry currentPlayer;
  final LeaderboardEntry? playerBelow;

  const LeaderboardNeighborhood({
    super.key,
    this.playerAbove,
    required this.currentPlayer,
    this.playerBelow,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Players near you in the leaderboard. ' +
             (playerAbove != null ? 'Player #${playerAbove!.position} is above you by ${playerAbove!.rankPoints - currentPlayer.rankPoints} points. ' : '') +
             'You are at position #${currentPlayer.position}. ' +
             (playerBelow != null ? 'Player #${playerBelow!.position} is below you.' : ''),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: SoteriaSpacing.sm, bottom: 8),
            child: SoteriaText.caption(
              'NEAR YOU',
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
          SoteriaCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                if (playerAbove != null) ...[
                  LeaderboardRow(entry: playerAbove!),
                  const Divider(height: 1, color: Colors.white10),
                ],
                LeaderboardRow(entry: currentPlayer, isCurrentUser: true),
                if (playerBelow != null) ...[
                  const Divider(height: 1, color: Colors.white10),
                  LeaderboardRow(entry: playerBelow!),
                ],
              ],
            ),
          ),
          if (playerAbove != null) 
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: SoteriaText.caption(
                '${playerAbove!.rankPoints - currentPlayer.rankPoints} RP to #${playerAbove!.position}',
                color: SoteriaColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}
