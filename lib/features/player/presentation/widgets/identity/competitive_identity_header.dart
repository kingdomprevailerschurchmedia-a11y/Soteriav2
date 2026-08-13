import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/features/player/domain/models/competitive_identity.dart';
import 'package:soteria/features/player/presentation/widgets/competitive_rank_badge.dart';
import 'competitive_title_widget.dart';

class CompetitiveIdentityHeader extends StatelessWidget {
  final CompetitiveIdentity identity;
  final bool isCompact;

  const CompetitiveIdentityHeader({
    super.key,
    required this.identity,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompact) return _buildCompact(context);

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SoteriaAvatar(
              size: 100,
              showGlow: true,
              frameStyle: _getFrameStyle(identity.rankProgress.tier.displayOrder),
            ),
            Positioned(
              bottom: 0,
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
        SizedBox(height: SoteriaSpacing.xl),
        Text(
          identity.profile.displayName,
          style: context.headlineMedium.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xs),
        CompetitiveTitleWidget(
          title: identity.equippedTitle,
          isLarge: true,
        ),
      ],
    );
  }

  Widget _buildCompact(BuildContext context) {
    return Row(
      children: [
        SoteriaAvatar(
          size: 52,
          showGlow: false,
        ),
        SizedBox(width: SoteriaSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                identity.profile.displayName,
                style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              CompetitiveTitleWidget(title: identity.equippedTitle),
            ],
          ),
        ),
        CompetitiveRankBadge(
          tierId: identity.rankProgress.tier.id,
          rankName: identity.rankProgress.currentRank,
          size: RankBadgeSize.small,
        ),
      ],
    );
  }

  dynamic _getFrameStyle(int tierOrder) {
    // Logic to map tier to frame style if applicable
    return null; 
  }
}
