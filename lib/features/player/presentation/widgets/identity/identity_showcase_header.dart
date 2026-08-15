import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/features/player/domain/models/competitive_identity.dart';
import 'package:soteria/features/player/presentation/widgets/competitive_rank_badge.dart';
import 'competitive_title_widget.dart';
import 'featured_badges_row.dart';

class IdentityShowcaseHeader extends StatelessWidget {
  final CompetitiveIdentity identity;

  const IdentityShowcaseHeader({
    super.key,
    required this.identity,
  });

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      hasGlow: true,
      glowColor: SoteriaColors.primary.withValues(alpha: 0.3),
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  SoteriaAvatar(
                    size: 80,
                    showGlow: true,
                  ),
                  Positioned(
                    bottom: -5,
                    right: -10,
                    child: CompetitiveRankBadge(
                      tierId: identity.rankProgress.tier.id,
                      rankName: identity.rankProgress.currentRank,
                      size: RankBadgeSize.medium,
                      hasGlow: true,
                    ),
                  ),
                ],
              ),
              SizedBox(width: SoteriaSpacing.xl),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      identity.profile.displayName,
                      style: context.headlineSmall.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '@${identity.profile.username}',
                      style: context.bodyMedium.copyWith(
                        color: SoteriaColors.muted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CompetitiveTitleWidget(title: identity.equippedTitle),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          FeaturedBadgesRow(
            badges: identity.featuredBadges,
            maxBadges: 3,
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SoteriaSpacing.md,
              vertical: SoteriaSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _CompactStat(
                  label: 'LEVEL',
                  value: identity.progression.currentLevel.toString(),
                  color: SoteriaColors.primary,
                ),
                _VerticalDivider(),
                _CompactStat(
                  label: 'POINTS',
                  value: identity.rankProgress.currentRP.toString(),
                  color: SoteriaColors.gold,
                ),
                _VerticalDivider(),
                _CompactStat(
                  label: 'WINS',
                  value: identity.profile.gamesWon.toString(),
                  color: SoteriaColors.success,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _CompactStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 8.sp,
            letterSpacing: 1.0,
          ),
        ),
        Text(
          value,
          style: context.titleMedium.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 24.h,
      color: Colors.white.withValues(alpha: 0.05),
    );
  }
}
