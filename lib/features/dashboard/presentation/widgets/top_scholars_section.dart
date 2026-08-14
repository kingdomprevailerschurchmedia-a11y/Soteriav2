import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/providers/avatar_providers.dart';
import '../../../../core/avatar/presentation/widgets/avatar_frame.dart';

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
                  Image.asset(
                    'assets/icons/top_scholars.png',
                    width: 24.w,
                    height: 24.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'TOP SCHOLARS',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.gold,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.muted,
                        fontWeight: FontWeight.w900,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: SoteriaColors.muted,
                      size: 18.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.md),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                color: const Color(0xFF9155FD).withValues(alpha: 0.15),
                width: 1.2,
              ),
              color: const Color(0xFF0B012A).withValues(alpha: 0.4),
            ),
            child: Column(
              children: [
                _ScholarRow(
                  rank: 1,
                  name: 'Hypatia',
                  role: 'Master',
                  xp: 24500,
                  color: SoteriaColors.gold,
                  avatarId: 'athena',
                ),
                _Divider(),
                _ScholarRow(
                  rank: 2,
                  name: 'Archimedes',
                  role: 'Master',
                  xp: 22100,
                  color: const Color(0xFFC0C0C0),
                  avatarId: 'isaac',
                ),
                _Divider(),
                _ScholarRow(
                  rank: 3,
                  name: 'Euler',
                  role: 'Expert',
                  xp: 19800,
                  color: const Color(0xFFCD7F32),
                  avatarId: 'elias',
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

class _ScholarRow extends ConsumerWidget {
  const _ScholarRow({
    required this.rank,
    required this.name,
    required this.role,
    required this.xp,
    required this.color,
    required this.avatarId,
  });

  final int rank;
  final String name;
  final String role;
  final int xp;
  final Color color;
  final String avatarId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatar = ref.watch(avatarCatalogProvider).getById(avatarId);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          _PositionBadge(rank: rank),
          SizedBox(width: 12.w),
          SoteriaAvatar(
            avatar: avatar,
            size: 33,
            frameStyle: _getFrameStyle(rank),
            showGlow: true,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                _RoleBadge(role: role, color: const Color(0xFF9155FD)),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${xp.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")} XP',
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: color,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(width: 8.w),
              _TrophyIcon(color: color),
            ],
          ),
        ],
      ),
    );
  }

  AvatarFrameStyle _getFrameStyle(int rank) {
    if (rank == 1) return AvatarFrameStyle.gold;
    if (rank == 2) return AvatarFrameStyle.silver;
    if (rank == 3) return AvatarFrameStyle.bronze;
    return AvatarFrameStyle.none;
  }
}

class _UserHighlightRow extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    const highlightColor = Color(0xFF9155FD);
    return Container(
      margin: EdgeInsets.all(6.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: highlightColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            child: Text(
              rank.toString(),
              style: context.titleMedium.copyWith(
                fontWeight: FontWeight.w900,
                color: highlightColor,
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 10.w),
          const SoteriaAvatar(
            size: 36,
            frameStyle: AvatarFrameStyle.purple,
            showGlow: true,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                _RoleBadge(role: role, color: highlightColor),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${xp.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")} XP',
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: highlightColor,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(width: 8.w),
              const _TrophyIcon(color: highlightColor),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.role, required this.color});
  final String role;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, color: color, size: 8.sp),
          SizedBox(width: 4.w),
          Text(
            role,
            style: context.labelSmall.copyWith(
              color: color,
              fontSize: 7.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrophyIcon extends StatelessWidget {
  const _TrophyIcon({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.6),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        Icon(
          Icons.emoji_events_rounded,
          color: color,
          size: 16.sp,
        ),
      ],
    );
  }
}

class _PositionBadge extends StatelessWidget {
  const _PositionBadge({required this.rank});
  final int rank;

  @override
  Widget build(BuildContext context) {
    String? assetPath;
    if (rank == 1) {
      assetPath = 'assets/icons/first_position_badge_transparent.png';
    } else if (rank == 2) {
      assetPath = 'assets/icons/second_position_badge_transparent_clean.png';
    } else if (rank == 3) {
      assetPath = 'assets/icons/third_position_badge_transparent_clean.png';
    }

    if (assetPath != null) {
      return Image.asset(
        assetPath,
        width: 24.w,
        height: 24.w,
        fit: BoxFit.contain,
      );
    }

    return Center(
      child: Text(
        rank.toString(),
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontWeight: FontWeight.w900,
          fontSize: 10.sp,
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
      thickness: 1,
      color: Colors.white.withValues(alpha: 0.05),
      indent: 52.w,
      endIndent: 16.w,
    );
  }
}
