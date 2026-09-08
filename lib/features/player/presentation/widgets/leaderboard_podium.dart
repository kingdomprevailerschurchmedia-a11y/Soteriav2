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
      width: double.infinity,
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1638).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOP PERFORMERS',
            style: context.labelSmall.copyWith(
              color: const Color(0xFF6B4EEA),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 10.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (podiumEntries[0] != null)
                Expanded(
                  child: _PodiumItem(
                    entry: podiumEntries[0]!,
                    rank: 2,
                  ),
                ),
              if (podiumEntries[1] != null)
                Expanded(
                  child: _PodiumItem(
                    entry: podiumEntries[1]!,
                    rank: 1,
                    isWinner: true,
                  ),
                ),
              if (podiumEntries[2] != null)
                Expanded(
                  child: _PodiumItem(
                    entry: podiumEntries[2]!,
                    rank: 3,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PodiumItem extends StatelessWidget {
  final LeaderboardEntry entry;
  final int rank;
  final bool isWinner;

  const _PodiumItem({
    required this.entry,
    required this.rank,
    this.isWinner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isWinner)
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Icon(
              Icons.workspace_premium_rounded,
              color: SoteriaColors.gold,
              size: 20.sp,
            ),
          ),
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(isWinner ? 3.r : 2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isWinner
                    ? const LinearGradient(
                        colors: [SoteriaColors.gold, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : LinearGradient(
                        colors: [
                          const Color(0xFF6B4EEA).withValues(alpha: 0.5),
                          Colors.transparent
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: isWinner
                      ? [
                          BoxShadow(
                            color: SoteriaColors.gold.withValues(alpha: 0.2),
                            blurRadius: 10,
                            spreadRadius: 1,
                          )
                        ]
                      : [],
                ),
                child: SoteriaAvatar(
                  avatar: AvatarCatalog().getById(entry.avatarId ?? ''),
                  imageUrl: entry.avatarUrl,
                  size: isWinner ? 64 : 52,
                ),
              ),
            ),
            Positioned(
              bottom: -4.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isWinner ? SoteriaColors.gold : const Color(0xFF6B4EEA),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.white24, width: 1),
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
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          entry.displayName,
          style: context.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 13.sp,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2.h),
        Text(
          '${entry.rankPoints} RP',
          style: context.bodyMedium.copyWith(
            color: SoteriaColors.gold,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.diamond_outlined,
                color: const Color(0xFF9D5BFF),
                size: 11.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                'NONE 0',
                style: context.labelSmall.copyWith(
                  color: const Color(0xFF77728A),
                  fontSize: 8.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

