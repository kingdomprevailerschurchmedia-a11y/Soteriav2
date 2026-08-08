import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_avatar.dart';

class TopScholarsSection extends StatelessWidget {
  const TopScholarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.emoji_events_rounded,
                    color: SoteriaColors.gold,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'TOP SCHOLARS',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.textSecondary,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w900,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Text(
                'View All',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.secondary,
                  fontWeight: FontWeight.w900,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xl),
          SoteriaCard(
            padding: EdgeInsets.zero,
            borderRadius: SoteriaRadius.xxl,
            child: Column(
              children: [
                _ScholarRow(
                  rank: 1,
                  name: 'Hypatia',
                  role: 'Master',
                  xp: 24500,
                  color: SoteriaColors.gold,
                ),
                _Divider(),
                _ScholarRow(
                  rank: 2,
                  name: 'Archimedes',
                  role: 'Master',
                  xp: 22100,
                  color: const Color(0xFFC0C0C0),
                ),
                _Divider(),
                _ScholarRow(
                  rank: 3,
                  name: 'Euler',
                  role: 'Expert',
                  xp: 19800,
                  color: const Color(0xFFCD7F32),
                ),
                _UserHighlightRow(
                  rank: 42,
                  name: 'You',
                  role: 'Student',
                  xp: 12500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScholarRow extends StatelessWidget {
  const _ScholarRow({
    required this.rank,
    required this.name,
    required this.role,
    required this.xp,
    required this.color,
  });

  final int rank;
  final String name;
  final String role;
  final int xp;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          _RankBadge(rank: rank, color: color),
          SizedBox(width: 16.w),
          const SoteriaAvatar(size: 40, hasBorder: false),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.w900,
                    color: SoteriaColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.stars_rounded,
                      color: SoteriaColors.primary,
                      size: 10.sp,
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        role,
                        style: context.labelSmall.copyWith(
                          color: SoteriaColors.muted,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${xp.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} XP',
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w900,
                  color: SoteriaColors.secondary,
                ),
              ),
              Icon(
                Icons.emoji_events_rounded,
                color: color.withValues(alpha: 0.5),
                size: 14.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserHighlightRow extends StatelessWidget {
  const _UserHighlightRow({
    required this.rank,
    required this.name,
    required this.role,
    required this.xp,
  });

  final int rank;
  final String name;
  final String role;
  final int xp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SoteriaColors.primary.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: SoteriaColors.primary.withValues(alpha: 0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32.w,
            child: Text(
              rank.toString(),
              style: context.titleMedium.copyWith(
                fontWeight: FontWeight.w900,
                color: SoteriaColors.secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 12.w),
          const SoteriaAvatar(size: 40, isOnline: true),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  role,
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            '${xp.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} XP',
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.w900,
              color: SoteriaColors.secondary,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.emoji_events_rounded,
            color: SoteriaColors.secondary,
            size: 18.sp,
          ),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank, required this.color});
  final int rank;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
        color: color.withValues(alpha: 0.1),
      ),
      child: Center(
        child: Text(
          rank.toString(),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Colors.white.withValues(alpha: 0.05),
      indent: 64.w,
      endIndent: 20.w,
    );
  }
}
