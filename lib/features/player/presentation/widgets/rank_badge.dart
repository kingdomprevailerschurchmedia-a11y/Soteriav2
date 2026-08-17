import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_badge.dart';

class RankBadge extends StatelessWidget {
  final String rankName;
  final String tierId;
  final bool isLarge;

  const RankBadge({
    super.key,
    required this.rankName,
    required this.tierId,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final String assetPath = _getRankAsset();
    final Color rankColor = _getRankColor();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: rankColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: rankColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            assetPath,
            width: isLarge ? 18.sp : 14.sp,
            height: isLarge ? 18.sp : 14.sp,
            fit: BoxFit.contain,
            errorBuilder: (context, _, __) => Icon(
              Icons.shield_rounded,
              color: rankColor,
              size: isLarge ? 18.sp : 14.sp,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            rankName.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: rankColor.withValues(alpha: 0.9),
              fontWeight: FontWeight.w900,
              fontSize: isLarge ? 11.sp : 9.sp,
              letterSpacing: 1.0,
            ),
          ),
        ],
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
        return SoteriaColors.muted;
    }
  }
}
