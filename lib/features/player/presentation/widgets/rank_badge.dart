import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
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
    return SoteriaBadge(
      label: rankName,
      variant: _getVariant(),
      icon: _getIcon(),
    );
  }

  SoteriaBadgeVariant _getVariant() {
    switch (tierId.toLowerCase()) {
      case 'gold':
      case 'platinum':
      case 'diamond':
      case 'master':
      case 'elite':
        return SoteriaBadgeVariant.gold;
      case 'bronze':
      case 'silver':
        return SoteriaBadgeVariant.muted;
      default:
        return SoteriaBadgeVariant.info;
    }
  }

  IconData _getIcon() {
    switch (tierId.toLowerCase()) {
      case 'elite':
        return Icons.verified_user_rounded;
      case 'master':
        return Icons.auto_awesome_rounded;
      case 'diamond':
        return Icons.diamond_rounded;
      default:
        return Icons.military_tech_rounded;
    }
  }
}
