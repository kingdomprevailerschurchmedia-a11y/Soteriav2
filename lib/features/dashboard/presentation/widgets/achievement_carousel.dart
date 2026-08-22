import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../player/presentation/providers/achievement_providers.dart';

class AchievementCarousel extends ConsumerWidget {
  const AchievementCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final definitions = ref.watch(achievementDefinitionsProvider);
    final earnedMap = ref.watch(playerAchievementMapProvider);
    final recentAchievements = ref.watch(recentAchievementsProvider);

    if (definitions.isEmpty) return const SizedBox.shrink();

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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            itemCount: definitions.length,
            itemBuilder: (context, index) {
              final def = definitions[index];
              final isUnlocked = earnedMap.containsKey(def.id);
              
              return _AchievementCard(
                title: def.title,
                isUnlocked: isUnlocked,
                icon: _getIcon(def.icon),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _getIcon(String iconName) {
    // In a real app, this would map iconName strings to actual Icons or Assets
    // For now, we'll use a placeholder logic
    switch (iconName) {
      case 'stars_rounded':
        return const Icon(Icons.stars_rounded, color: SoteriaColors.gold, size: 32);
      case 'psychology_rounded':
        return const Icon(Icons.psychology_rounded, color: Colors.white, size: 32);
      case 'emoji_events_rounded':
        return const Icon(Icons.emoji_events_rounded, color: SoteriaColors.gold, size: 32);
      default:
        return const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 32);
    }
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
