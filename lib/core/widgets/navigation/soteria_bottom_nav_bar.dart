import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../design_system/colors/soteria_colors.dart';
import '../../design_system/spacing/soteria_spacing.dart';
import '../../design_system/animations/soteria_animations.dart';
import '../../design_system/radius/soteria_radius.dart';
import '../glass_surface.dart';

class SoteriaBottomNavBar extends StatelessWidget {
  const SoteriaBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        SoteriaSpacing.lg,
        0,
        SoteriaSpacing.lg,
        SoteriaSpacing.lg + MediaQuery.of(context).padding.bottom,
      ),
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SoteriaRadius.full),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: GlassSurface(
            blur: 32, // High blur
            borderRadius: BorderRadius.circular(SoteriaRadius.full),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            opacity: 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavButton(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isSelected: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
                _NavButton(
                  icon: Icons.play_arrow_rounded,
                  label: 'Practice',
                  isSelected: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
                _NavButton(
                  icon: Icons.bar_chart_rounded,
                  label: 'Stats',
                  isSelected: currentIndex == 2,
                  onTap: () => onTap(2),
                ),
                _NavButton(
                  icon: Icons.stars_rounded,
                  label: 'Rewards',
                  isSelected: currentIndex == 3,
                  onTap: () => onTap(3),
                ),
                _NavButton(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  isSelected: currentIndex == 4,
                  onTap: () => onTap(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        selected: isSelected,
        label: label,
        button: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: SoteriaAnimations.fast,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? SoteriaColors.primary.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(SoteriaRadius.full),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: SoteriaColors.primary.withValues(alpha: 0.2),
                      blurRadius: 15,
                      spreadRadius: -2,
                    ),
                ],
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : SoteriaColors.muted,
                size: 28.sp,
              ),
            ),
            if (isSelected) ...[
              SizedBox(height: 4.h),
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: SoteriaColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: SoteriaColors.primary.withValues(alpha: 0.8),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
