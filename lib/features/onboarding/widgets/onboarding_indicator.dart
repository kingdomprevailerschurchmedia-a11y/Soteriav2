import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 5.h,
      width: isActive ? 24.w : 6.w,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF8A55FD)
            : Colors.grey.withValues(alpha: 0.3),
        borderRadius: SoteriaRadius.brFull,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFF8A55FD).withValues(alpha: 0.4),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }
}
