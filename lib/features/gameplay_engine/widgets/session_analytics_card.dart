import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import '../models/game_result.dart';

class SessionAnalyticsCard extends StatelessWidget {
  final GameResult result;

  const SessionAnalyticsCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PERFORMANCE INSIGHTS',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.8,
            children: [
              _InsightItem(
                label: 'Accuracy',
                value: '${(result.accuracy * 100).toInt()}%',
                icon: Icons.track_changes_rounded,
                color: SoteriaColors.success,
              ),
              _InsightItem(
                label: 'Avg Response',
                value: '${result.avgResponseTime.inSeconds}s',
                icon: Icons.timer_outlined,
                color: SoteriaColors.info,
              ),
              _InsightItem(
                label: 'Best Streak',
                value: result.maxStreak.toString(),
                icon: Icons.bolt_rounded,
                color: Colors.orange,
              ),
              _InsightItem(
                label: 'Fastest',
                value: '${result.fastestAnswerTime.inSeconds}s',
                icon: Icons.speed_rounded,
                color: Colors.cyanAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InsightItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _InsightItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 14.sp, color: color),
              SizedBox(width: 6.w),
              Text(
                label,
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
