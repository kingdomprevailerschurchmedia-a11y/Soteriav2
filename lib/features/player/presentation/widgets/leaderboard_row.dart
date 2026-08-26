import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../domain/models/leaderboard_entry.dart';
import '../providers/identity_providers.dart';
import 'identity/competitive_title_widget.dart';
import '../screens/public_competitive_profile_screen.dart';
import 'competitive_rank_badge.dart';

class LeaderboardRow extends ConsumerWidget {
  final LeaderboardEntry entry;
  final bool isCurrentUser;
  final int? calculatedPosition;

  const LeaderboardRow({
    super.key,
    required this.entry,
    this.isCurrentUser = false,
    this.calculatedPosition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = calculatedPosition ?? entry.position;

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PublicCompetitiveProfileScreen(userId: entry.userId),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.md,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          gradient: isCurrentUser
              ? LinearGradient(
                  colors: [
                    const Color(0xFF6B4EEA).withValues(alpha: 0.2),
                    const Color(0xFF6B4EEA).withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          border: isCurrentUser
              ? Border(
                  left: BorderSide(color: const Color(0xFF6B4EEA), width: 3.w),
                )
              : null,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 40.w,
              child: _LeaderboardPositionBadge(rank: position),
            ),
            Container(
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _getRankRingColor(position),
                  width: 1.5,
                ),
              ),
              child: SoteriaAvatar(
                avatar: AvatarCatalog().getById(entry.avatarId ?? ''),
                imageUrl: entry.avatarUrl,
                size: 48,
              ),
            ),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.displayName,
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isCurrentUser ? SoteriaColors.gold : Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${entry.rankTier} ${entry.division}',
                    style: context.bodySmall.copyWith(
                      color: const Color(0xFF77728A),
                    ),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            CompetitiveRankBadge(
              rankName: '', 
              tierId: entry.rankTier.toLowerCase(),
              size: RankBadgeSize.small,
            ),
          ],
        ),
      ),
    );
  }

  Color _getRankRingColor(int rank) {
    if (rank == 1) return SoteriaColors.gold;
    if (rank == 2) return const Color(0xFFB9B6C9);
    if (rank == 3) return const Color(0xFFCD7F32);
    return Colors.transparent;
  }
}

class _LeaderboardPositionBadge extends StatelessWidget {
  const _LeaderboardPositionBadge({required this.rank});
  final int rank;

  @override
  Widget build(BuildContext context) {
    if (rank <= 3) {
      return Center(
        child: Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _getRankColor(rank).withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              rank.toString(),
              style: context.labelMedium.copyWith(
                color: _getRankColor(rank),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return Center(
      child: Text(
        rank.toString(),
        style: context.labelLarge.copyWith(
          color: const Color(0xFF5F5A73),
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return SoteriaColors.gold;
    if (rank == 2) return const Color(0xFFB9B6C9);
    if (rank == 3) return const Color(0xFFCD7F32);
    return const Color(0xFF5F5A73);
  }
}

