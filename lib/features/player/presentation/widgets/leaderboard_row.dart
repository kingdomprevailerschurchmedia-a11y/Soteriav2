import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../domain/models/leaderboard_entry.dart';
import 'rank_badge.dart';

class LeaderboardRow extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool isCurrentUser;

  const LeaderboardRow({
    super.key,
    required this.entry,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.md,
        vertical: SoteriaSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? SoteriaColors.primary.withValues(alpha: 0.1)
            : Colors.transparent,
        border: isCurrentUser
            ? Border.symmetric(
                vertical: BorderSide(color: SoteriaColors.primary, width: 2.w),
              )
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32.w,
            child: Text(
              '${entry.position}',
              style: context.labelLarge.copyWith(
                color: isCurrentUser
                    ? SoteriaColors.primary
                    : SoteriaColors.muted,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SoteriaAvatar(
            avatar: AvatarCatalog().getById(entry.avatarId ?? ''),
            size: 40,
            rank: entry.position,
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.displayName,
                  style: context.bodyLarge.copyWith(
                    fontWeight: isCurrentUser
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isCurrentUser
                        ? SoteriaColors.textPrimary
                        : SoteriaColors.textSecondary,
                  ),
                ),
                Text(
                  '${entry.rankTier} ${entry.division}',
                  style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${entry.rankPoints} RP',
                style: context.titleSmall.copyWith(
                  color: SoteriaColors.gold,
                  fontWeight: FontWeight.w900,
                ),
              ),
              RankBadge(
                rankName:
                    '', // Label hidden for compact row if needed, but RankBadge shows it.
                tierId: entry.rankTier.toLowerCase(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
