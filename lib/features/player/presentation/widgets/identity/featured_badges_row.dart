import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/features/player/domain/models/competitive_badge.dart';

class FeaturedBadgesRow extends StatelessWidget {
  final List<CompetitiveBadge> badges;
  final int maxBadges;
  final bool isLocked;

  const FeaturedBadgesRow({
    super.key,
    required this.badges,
    this.maxBadges = 5,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxBadges, (index) {
        if (index < badges.length) {
          return _BadgeItem(badge: badges[index]);
        }
        return _EmptyBadgeSlot(isLocked: isLocked);
      }),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final CompetitiveBadge badge;

  const _BadgeItem({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      margin: EdgeInsets.only(right: SoteriaSpacing.sm),
      decoration: BoxDecoration(
        color: SoteriaColors.gold.withValues(alpha: 0.1),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(
          color: SoteriaColors.gold.withValues(alpha: 0.3),
        ),
      ),
      child: Tooltip(
        message: badge.name,
        child: Icon(
          Icons.emoji_events_rounded, // Placeholder for iconAsset
          color: SoteriaColors.gold,
          size: 20.sp,
        ),
      ),
    );
  }
}

class _EmptyBadgeSlot extends StatelessWidget {
  final bool isLocked;

  const _EmptyBadgeSlot({required this.isLocked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      margin: EdgeInsets.only(right: SoteriaSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Icon(
        isLocked ? Icons.lock_outline_rounded : Icons.add_rounded,
        color: SoteriaColors.muted.withValues(alpha: 0.3),
        size: 16.sp,
      ),
    );
  }
}
