import 'package:flutter/material.dart';
import '../../design_system/colors/soteria_colors.dart';
import '../../design_system/spacing/soteria_spacing.dart';
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
      child: GlassSurface(
        borderRadius: BorderRadius.circular(32),
        padding: const EdgeInsets.symmetric(vertical: 8),
        opacity: 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavButton(
              icon: Icons.home_filled,
              isSelected: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavButton(
              icon: Icons.play_circle_filled_rounded,
              isSelected: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            _NavButton(
              icon: Icons.leaderboard_rounded,
              isSelected: currentIndex == 2,
              onTap: () => onTap(2),
            ),
            _NavButton(
              icon: Icons.stars_rounded,
              isSelected: currentIndex == 3,
              onTap: () => onTap(3),
            ),
            _NavButton(
              icon: Icons.person_rounded,
              isSelected: currentIndex == 4,
              onTap: () => onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? SoteriaColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? SoteriaColors.primary : SoteriaColors.muted,
          size: 24,
        ),
      ),
    );
  }
}
