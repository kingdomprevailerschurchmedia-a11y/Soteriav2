import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';

class GameplayHeaderStats extends StatelessWidget {
  final int score;
  final int xp;
  final int coins;

  const GameplayHeaderStats({
    super.key,
    required this.score,
    required this.xp,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _StatItem(
          icon: Icons.emoji_events_outlined,
          label: 'SCORE',
          value: score.toString(),
          color: SoteriaColors.primary,
        ),
        _StatItem(
          icon: Icons.bolt,
          label: 'XP',
          value: '+$xp',
          color: SoteriaColors.gold,
        ),
        _StatItem(
          icon: Icons.monetization_on_outlined,
          label: 'COINS',
          value: coins.toString(),
          color: Colors.amber,
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16.sp),
            SizedBox(width: 4.w),
            Text(
              value,
              style: TextStyle(
                color: SoteriaColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: TextStyle(
            color: SoteriaColors.textSecondary,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}
