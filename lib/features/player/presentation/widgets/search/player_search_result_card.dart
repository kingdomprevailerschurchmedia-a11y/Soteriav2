import 'package:flutter/material.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../../core/avatar/data/avatar_catalog.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import 'package:soteria/features/player/domain/models/public_competitive_profile.dart';
import '../competitive_rank_badge.dart';
import '../identity/competitive_title_widget.dart';

class PlayerSearchResultCard extends StatelessWidget {
  final PublicCompetitiveProfile profile;
  final VoidCallback onTap;

  const PlayerSearchResultCard({
    super.key,
    required this.profile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      onTap: onTap,
      padding: EdgeInsets.all(SoteriaSpacing.md),
      margin: EdgeInsets.only(bottom: SoteriaSpacing.sm),
      child: Row(
        children: [
          SoteriaAvatar(
            avatar: AvatarCatalog().getById(profile.avatarId),
            size: 48,
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.displayName,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (profile.equippedTitle != null) ...[
                  SizedBox(height: SoteriaSpacing.xs),
                  CompetitiveTitleWidget(title: profile.equippedTitle!),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CompetitiveRankBadge(
                rankName: profile.currentRank,
                tierId: profile.rankTier.toLowerCase(),
                size: RankBadgeSize.small,
              ),
              SizedBox(height: SoteriaSpacing.xs),
              Text(
                '${profile.rankPoints} RP',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
