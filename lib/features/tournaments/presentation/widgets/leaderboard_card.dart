import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import '../../domain/models/tournament_ranking.dart';
import 'rank_badge.dart';

class LeaderboardCard extends StatelessWidget {
  final TournamentRanking ranking;
  final bool isCurrentUser;

  const LeaderboardCard({
    super.key,
    required this.ranking,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.md,
        vertical: SoteriaSpacing.sm,
      ),
      borderColor: isCurrentUser
          ? SoteriaColors.gold.withValues(alpha: 0.5)
          : null,
      child: Row(
        children: [
          RankBadge(rank: ranking.rank, size: 36),
          SizedBox(width: SoteriaSpacing.md),
          CircleAvatar(
            radius: 18,
            backgroundImage: ranking.photoUrl.isNotEmpty
                ? NetworkImage(ranking.photoUrl)
                : null,
            child: ranking.photoUrl.isEmpty ? const Icon(Icons.person) : null,
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ranking.displayName,
                  style: context.bodyLarge.copyWith(
                    fontWeight: isCurrentUser
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isCurrentUser
                        ? SoteriaColors.gold
                        : SoteriaColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (ranking.isTie)
                  Text(
                    'TIE-BREAKER APPLIED',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      fontSize: 8.sp,
                    ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ranking.score.toString(),
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '${(ranking.accuracy * 100).toInt()}%',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
