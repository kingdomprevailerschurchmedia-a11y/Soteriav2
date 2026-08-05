import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import '../models/game_result.dart';

class CompetitiveStatisticsCard extends StatelessWidget {
  final GameResult result;

  const CompetitiveStatisticsCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SESSION STATISTICS',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Wrap(
            spacing: SoteriaSpacing.lg,
            runSpacing: SoteriaSpacing.lg,
            children: [
              _StatBox(
                label: 'AVG SPEED',
                value:
                    '${(result.avgResponseTime.inMilliseconds / 1000).toStringAsFixed(1)}s',
                icon: Icons.timer_outlined,
              ),
              _StatBox(
                label: 'BEST STREAK',
                value: '${result.maxStreak}',
                icon: Icons.local_fire_department_outlined,
                color: SoteriaColors.error,
              ),
              _StatBox(
                label: 'FASTEST',
                value:
                    '${(result.fastestAnswerTime.inMilliseconds / 1000).toStringAsFixed(1)}s',
                icon: Icons.bolt_rounded,
                color: SoteriaColors.success,
              ),
              _StatBox(
                label: 'QUESTIONS',
                value: '${result.totalQuestions}',
                icon: Icons.help_outline_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  const _StatBox({
    required this.label,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final width =
        (1.sw - (SoteriaSpacing.xl * 2) - (SoteriaSpacing.lg * 2) - 40) / 2;

    return Container(
      width: width > 0 ? width : 150.w,
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(SoteriaRadius.md),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color ?? SoteriaColors.muted, size: 20),
          SizedBox(height: SoteriaSpacing.sm),
          Text(
            value,
            style: context.titleMedium.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
