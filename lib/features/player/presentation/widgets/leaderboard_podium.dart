import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../domain/models/leaderboard_entry.dart';
import 'rank_badge.dart';

class LeaderboardPodium extends StatelessWidget {
  final List<LeaderboardEntry> topEntries;

  const LeaderboardPodium({super.key, required this.topEntries});

  @override
  Widget build(BuildContext context) {
    if (topEntries.isEmpty) return const SizedBox.shrink();

    // Reorder for Podium: [2, 1, 3]
    final podiumEntries = List<LeaderboardEntry?>.filled(3, null);
    if (topEntries.isNotEmpty) podiumEntries[1] = topEntries[0];
    if (topEntries.length >= 2) podiumEntries[0] = topEntries[1];
    if (topEntries.length >= 3) podiumEntries[2] = topEntries[2];

    return Container(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (podiumEntries[0] != null)
            Flexible(
              child: _PodiumItem(
                entry: podiumEntries[0]!,
                rank: 2,
                height: 120.h,
              ),
            ),
          SizedBox(width: SoteriaSpacing.md),
          if (podiumEntries[1] != null)
            Flexible(
              child: _PodiumItem(
                entry: podiumEntries[1]!,
                rank: 1,
                height: 150.h,
                isWinner: true,
              ),
            ),
          SizedBox(width: SoteriaSpacing.md),
          if (podiumEntries[2] != null)
            Flexible(
              child: _PodiumItem(
                entry: podiumEntries[2]!,
                rank: 3,
                height: 100.h,
              ),
            ),
        ],
      ),
    );
  }
}

class _PodiumItem extends StatelessWidget {
  final LeaderboardEntry entry;
  final int rank;
  final double height;
  final bool isWinner;

  const _PodiumItem({
    required this.entry,
    required this.rank,
    required this.height,
    this.isWinner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SoteriaAvatar(
              avatar: AvatarCatalog().getById(entry.avatarId ?? ''),
              imageUrl: entry.avatarUrl,
              size: isWinner ? 64 : 52,
              rank: entry.position,
            ),
            if (isWinner)
              Positioned(
                top: -8.h,
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: SoteriaColors.gold,
                  size: 20.sp,
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: isWinner ? SoteriaColors.gold : SoteriaColors.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                '#$rank',
                style: context.labelSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.sm),
        Text(
          entry.displayName,
          style: context.labelLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: isWinner
                ? SoteriaColors.textPrimary
                : SoteriaColors.textSecondary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '${entry.rankPoints} RP',
          style: context.bodySmall.copyWith(
            color: SoteriaColors.gold,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        RankBadge(
          rankName: '${entry.rankTier} ${entry.division}',
          tierId: entry.rankTier.toLowerCase(),
        ),
      ],
    );
  }
}
