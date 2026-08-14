import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';

class AchievementCarousel extends StatelessWidget {
  const AchievementCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          child: Text(
            'RECENT ACHIEVEMENTS',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            children: [
              _AchievementCard(
                title: 'First Win',
                isUnlocked: true,
                icon: Image.asset(
                  'assets/icons/first_position_badge_transparent.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                ),
              ),
              _AchievementCard(
                title: 'Logic Master',
                isUnlocked: true,
                icon: const Icon(
                  Icons.psychology_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              _AchievementCard(
                title: 'Century',
                isUnlocked: false,
                icon: Image.asset(
                  'assets/icons/coin_icon.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                ),
              ),
              _AchievementCard(
                title: 'Streak 7',
                isUnlocked: false,
                icon: Image.asset(
                  'assets/icons/streak_icon.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({
    required this.title,
    required this.isUnlocked,
    required this.icon,
  });

  final String title;
  final bool isUnlocked;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: SoteriaSpacing.md),
      child: GlassSurface(
        borderRadius: BorderRadius.circular(20),
        opacity: isUnlocked ? 0.05 : 0.02,
        child: Padding(
          padding: EdgeInsets.all(SoteriaSpacing.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isUnlocked
                  ? icon
                  : Icon(
                      Icons.lock_rounded,
                      color: SoteriaColors.muted.withValues(alpha: 0.3),
                      size: 32,
                    ),
              SizedBox(height: SoteriaSpacing.sm),
              Text(
                title,
                style: context.labelSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isUnlocked ? Colors.white : SoteriaColors.muted,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
