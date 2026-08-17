import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../design_system/colors/soteria_colors.dart';
import '../../design_system/spacing/soteria_spacing.dart';
import '../../design_system/animations/soteria_animations.dart';
import '../../design_system/radius/soteria_radius.dart';
import '../../utils/soteria_responsive.dart';
import '../glass_surface.dart';

class SoteriaBottomNavBar extends StatelessWidget {
  const SoteriaBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.unreadCount = 0,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final isShort = SoteriaResponsive.isShortScreen(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
        0,
        SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
        (isShort ? 4.h : 8.h) + bottomInset,
      ),
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
            borderRadius: BorderRadius.circular(SoteriaRadius.full),
            padding: EdgeInsets.symmetric(
              vertical: isShort ? 10.h : 12.h,
              horizontal: 8.w,
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1,
            ),
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
                  badgeCount: unreadCount,
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
    this.badgeCount = 0,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final isShort = SoteriaResponsive.isShortScreen(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        selected: isSelected,
        label: label,
        button: true,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: SoteriaAnimations.fast,
              padding: EdgeInsets.symmetric(
                horizontal: isShort ? 12.w : 14.w,
                vertical: isShort ? 4.h : 6.h,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: isSelected ? SoteriaColors.secondary : SoteriaColors.muted,
                    size: isShort ? 18.sp : 22.sp,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : SoteriaColors.muted,
                      fontSize: 9.sp,
                      fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (badgeCount > 0)
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: SoteriaColors.error,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    badgeCount > 9 ? '9+' : '$badgeCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (isSelected)
              Positioned(
                bottom: -2.h,
                child: Container(
                  width: 6.r,
                  height: 6.r,
                  decoration: BoxDecoration(
                    color: SoteriaColors.secondary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: SoteriaColors.secondary.withValues(alpha: 0.8),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


