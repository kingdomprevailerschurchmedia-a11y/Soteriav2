import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';

enum RankBadgeSize { small, medium, large, extraLarge }

class CompetitiveRankBadge extends StatelessWidget {
  final String tierId;
  final String rankName;
  final RankBadgeSize size;
  final bool hasGlow;

  const CompetitiveRankBadge({
    super.key,
    required this.tierId,
    required this.rankName,
    this.size = RankBadgeSize.medium,
    this.hasGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    final double badgeSize = _getBadgeSize();
    final Color rankColor = _getRankColor();
    final String assetPath = _getRankAsset();

    return Semantics(
      label: 'Rank Badge: $rankName',
      child: SizedBox(
        width: badgeSize,
        height: badgeSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Glow for Elite/Master
            if (hasGlow || tierId.toLowerCase() == 'elite' || tierId.toLowerCase() == 'master')
              Container(
                width: badgeSize * 0.8,
                height: badgeSize * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: rankColor.withValues(alpha: 0.3),
                      blurRadius: badgeSize * 0.5,
                      spreadRadius: badgeSize * 0.1,
                    ),
                  ],
                ),
              ),

            Image.asset(
              assetPath,
              width: badgeSize,
              height: badgeSize,
              fit: BoxFit.contain,
              errorBuilder: (context, _, __) => Icon(
                Icons.shield_rounded,
                color: rankColor.withValues(alpha: 0.5),
                size: badgeSize * 0.6,
              ),
            ),

            // Removed redundant rank name text as it's now baked into the PNG assets
          ],
        ),
      ),
    );
  }

  String _getRankAsset() {
    final id = tierId.toLowerCase();
    switch (id) {
      case 'unranked':
      case 'none':
        return 'assets/ranks/unranked_badge.png';
      case 'bronze':
        return 'assets/ranks/bronze_badge.png';
      case 'silver':
        return 'assets/ranks/silver_badge.png';
      case 'gold':
        return 'assets/ranks/gold_badge.png';
      case 'platinum':
        return 'assets/ranks/platinium_badge.png';
      case 'diamond':
        return 'assets/ranks/diamond_badge.png';
      case 'master':
        return 'assets/ranks/master_badge.png';
      case 'elite':
        return 'assets/ranks/elite_badge.png';
      default:
        return 'assets/ranks/unranked_badge.png';
    }
  }

  double _getBadgeSize() {
    switch (size) {
      case RankBadgeSize.small:
        return 42.r;
      case RankBadgeSize.medium:
        return 72.r;
      case RankBadgeSize.large:
        return 90.r;
      case RankBadgeSize.extraLarge:
        return 140.r;
    }
  }

  Color _getRankColor() {
    switch (tierId.toLowerCase()) {
      case 'gold':
        return SoteriaColors.gold;
      case 'platinum':
        return SoteriaColors.platinum;
      case 'diamond':
        return SoteriaColors.diamond;
      case 'master':
        return SoteriaColors.master;
      case 'elite':
        return SoteriaColors.elite;
      case 'silver':
        return SoteriaColors.silver;
      case 'bronze':
        return SoteriaColors.bronze;
      default:
        return SoteriaColors.textSecondary;
    }
  }
}
