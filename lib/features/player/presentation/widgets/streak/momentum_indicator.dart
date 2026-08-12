import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../domain/models/momentum.dart';

class MomentumIndicator extends StatelessWidget {
  final CompetitiveMomentum momentum;

  const MomentumIndicator({super.key, required this.momentum});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: _getStateColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: _getStateColor().withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPulsingDot(),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                momentum.state.name.toUpperCase(),
                style: context.labelSmall.copyWith(
                  color: _getStateColor(),
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              if (momentum.reason.isNotEmpty)
                Text(
                  momentum.reason,
                  style: context.bodySmall.copyWith(fontSize: 10.sp),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPulsingDot() {
    return Container(
      width: 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        color: _getStateColor(),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _getStateColor().withValues(alpha: 0.5),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }

  Color _getStateColor() {
    switch (momentum.state) {
      case MomentumState.peak:
        return SoteriaColors.gold;
      case MomentumState.strong:
        return SoteriaColors.success;
      case MomentumState.building:
        return SoteriaColors.primary;
      case MomentumState.cooling:
        return SoteriaColors.warning;
      case MomentumState.none:
        return SoteriaColors.muted;
    }
  }
}
