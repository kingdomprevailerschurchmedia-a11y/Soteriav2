import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class RankBadge extends StatelessWidget {
  final int rank;
  final double size;

  const RankBadge({super.key, required this.rank, this.size = 40});

  @override
  Widget build(BuildContext context) {
    final color = _getRankColor();
    final label = _getRankLabel();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      ),
      child: Center(
        child: Text(
          label,
          style: context.titleMedium.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: (size * 0.4).sp,
          ),
        ),
      ),
    );
  }

  Color _getRankColor() {
    if (rank == 1) return SoteriaColors.gold;
    if (rank == 2) return const Color(0xFFC0C0C0); // Silver
    if (rank == 3) return const Color(0xFFCD7F32); // Bronze
    return SoteriaColors.primary;
  }

  String _getRankLabel() {
    if (rank <= 0) return '-';
    return rank.toString();
  }
}
