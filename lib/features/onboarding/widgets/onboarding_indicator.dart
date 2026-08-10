import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  final int currentIndex;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => _IndicatorDot(isActive: index == currentIndex),
      ),
    );
  }
}

class _IndicatorDot extends StatelessWidget {
  const _IndicatorDot({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      height: 8.h,
      width: isActive ? 28.w : 8.w,
      decoration: BoxDecoration(
        color: isActive
            ? SoteriaColors.gold
            : SoteriaColors.secondary.withValues(alpha: 0.2),
        borderRadius: SoteriaRadius.brFull,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: SoteriaColors.gold.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
    );
  }
}
