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
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final isShort = SoteriaResponsive.isShortScreen(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
        0,
        SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
        (isShort ? SoteriaSpacing.smStatic : SoteriaSpacing.mdStatic) +
            bottomInset,
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
              vertical: isShort ? 6.h : 10.h,
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
    final isShort = SoteriaResponsive.isShortScreen(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        selected: isSelected,
        label: label,
        button: true,
        child: AnimatedContainer(
          duration: SoteriaAnimations.fast,
          padding: EdgeInsets.symmetric(
            horizontal: isShort ? 12.w : 16.w,
            vertical: isShort ? 8.h : 10.h,
          ),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF7C4DFF), Color(0xFF5B3FD9)],
                  )
                : null,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: const Color(0xFF7C4DFF).withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: -2,
                ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : SoteriaColors.muted,
                size: isShort ? 20.sp : 24.sp,
              ),
              if (isSelected) ...[
                SizedBox(height: 4.h),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
