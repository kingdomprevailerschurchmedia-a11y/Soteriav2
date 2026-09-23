import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../gameplay_engine/models/pro_mode_config.dart';
import '../../../providers/pro_lobby_providers.dart';

class ProSessionSummaryCard extends ConsumerWidget {
  const ProSessionSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview = ref.watch(rewardPreviewProvider);
    final riskLevel = ref.watch(riskCalculatorProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.assignment_rounded, color: SoteriaColors.gold, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'PRO SESSION SUMMARY',
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.gold,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w900,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: SoteriaColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: SoteriaColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        '${preview['multiplier']}X MULTIPLIER',
                        style: context.labelSmall.copyWith(
                          color: SoteriaColors.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 8.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SummaryItem(
                      label: 'Risk Level',
                      value: riskLevel.label.toUpperCase(),
                      icon: Icons.warning_amber_rounded,
                      color: _getRiskColor(riskLevel),
                    ),
                    _VerticalDivider(),
                    _SummaryItem(
                      label: 'Reward',
                      value: '+ ${preview['potentialXP']} XP',
                      icon: Icons.bolt_rounded,
                      color: SoteriaColors.gold,
                      isReward: true,
                    ),
                    _VerticalDivider(),
                    _SummaryItem(
                      label: 'Win Cap',
                      value: '${preview['potentialCoins']} Coins',
                      iconWidget: Image.asset(
                        'assets/icons/coin_icon.png',
                        width: 18.sp,
                        height: 18.sp,
                      ),
                      color: const Color(0xFF7C4DFF),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: SoteriaColors.gold.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.security_rounded, color: SoteriaColors.gold, size: 16),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Higher difficulty sessions yield greater multipliers but carry higher risk.',
                    style: context.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 10.sp,
                      height: 1.4,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: Colors.white.withValues(alpha: 0.2), size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getRiskColor(RiskLevel level) {
    switch (level) {
      case RiskLevel.low:
        return SoteriaColors.success;
      case RiskLevel.medium:
        return SoteriaColors.gold;
      case RiskLevel.high:
        return Colors.orange;
      case RiskLevel.extreme:
        return SoteriaColors.error;
    }
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.value,
    this.icon,
    this.iconWidget,
    required this.color,
    this.isReward = false,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Widget? iconWidget;
  final Color color;
  final bool isReward;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: iconWidget ?? Icon(icon, color: color, size: 18.sp),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.labelSmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    value,
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      color: isReward ? SoteriaColors.gold : Colors.white,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30.h,
      color: Colors.white.withValues(alpha: 0.1),
    );
  }
}
