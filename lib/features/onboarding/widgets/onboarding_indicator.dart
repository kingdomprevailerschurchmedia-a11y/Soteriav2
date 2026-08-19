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
      height: 6.h,
      width: isActive ? 32.w : 8.w,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFFB456FF)
            : Colors.white.withValues(alpha: 0.1),
        borderRadius: SoteriaRadius.brFull,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFFB456FF).withValues(alpha: 0.5),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }
}
