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

    return Semantics(
      label: 'Rank Badge: $rankName',
      child: Container(
        width: badgeSize,
        height: badgeSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow:
              hasGlow
                  ? [
                    BoxShadow(
                      color: rankColor.withValues(alpha: 0.3),
                      blurRadius: badgeSize / 2,
                      spreadRadius: badgeSize / 8,
                    ),
                  ]
                  : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer Ring
            Container(
              width: badgeSize,
              height: badgeSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: rankColor.withValues(alpha: 0.5),
                  width: badgeSize * 0.05,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    rankColor.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Inner Emblem
            Icon(
              _getTierIcon(),
              color: rankColor,
              size: badgeSize * 0.6,
            ),
            // Division Marker (if applicable)
            if (_getDivision() > 0)
              Positioned(
                bottom: badgeSize * 0.05,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SoteriaSpacing.xs,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: SoteriaColors.background,
                    borderRadius: BorderRadius.circular(SoteriaSpacing.xs),
                    border: Border.all(
                      color: rankColor.withValues(alpha: 0.5),
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    _getDivisionRoman(),
                    style: TextStyle(
                      color: rankColor,
                      fontSize: badgeSize * 0.15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  double _getBadgeSize() {
    switch (size) {
      case RankBadgeSize.small:
        return 32.w;
      case RankBadgeSize.medium:
        return 64.w;
      case RankBadgeSize.large:
        return 128.w;
      case RankBadgeSize.extraLarge:
        return 200.w;
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

  IconData _getTierIcon() {
    switch (tierId.toLowerCase()) {
      case 'gold':
        return Icons.military_tech_rounded;
      case 'platinum':
        return Icons.verified_user_rounded;
      case 'diamond':
        return Icons.diamond_rounded;
      case 'master':
        return Icons.auto_awesome_rounded;
      case 'elite':
        return Icons.workspace_premium_rounded;
      default:
        return Icons.shield_rounded;
    }
  }

  int _getDivision() {
    final parts = rankName.split(' ');
    if (parts.length < 2) return 0;
    final roman = parts[1];
    switch (roman) {
      case 'I':
        return 1;
      case 'II':
        return 2;
      case 'III':
        return 3;
      default:
        return 0;
    }
  }

  String _getDivisionRoman() {
    final parts = rankName.split(' ');
    return parts.length > 1 ? parts[1] : '';
  }
}
