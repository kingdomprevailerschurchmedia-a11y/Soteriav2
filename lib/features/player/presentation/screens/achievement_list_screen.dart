import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../providers/achievement_providers.dart';
import '../../domain/models/achievement.dart';

class AchievementListScreen extends ConsumerWidget {
  const AchievementListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final definitions = ref.watch(achievementDefinitionsProvider);
    final earnedMap = ref.watch(playerAchievementMapProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('ACHIEVEMENTS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        cacheExtent: 1000,
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        itemCount: AchievementCategory.values.length,
        itemBuilder: (context, catIndex) {
          final category = AchievementCategory.values[catIndex];
          final catDefinitions = definitions.where((d) => d.category == category).toList();
          
          if (catDefinitions.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
                child: Text(
                  category.name.toUpperCase(),
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              ...catDefinitions.map((def) {
                final playerState = earnedMap[def.id];
                return RepaintBoundary(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
                    child: _AchievementCard(
                      definition: def,
                      playerState: playerState,
                    ),
                  ),
                );
              }),
              SoteriaSpacing.gapLG,
            ],
          );
        },
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final AchievementDefinition definition;
  final PlayerAchievement? playerState;

  const _AchievementCard({
    required this.definition,
    this.playerState,
  });

  @override
  Widget build(BuildContext context) {
    final isUnlocked = playerState?.status == AchievementStatus.unlocked ||
        playerState?.status == AchievementStatus.claimed;
    
    final progress = playerState?.currentValue ?? 0.0;
    final progressPercentage = (progress / definition.threshold).clamp(0.0, 1.0);

    return Semantics(
      label: 'Achievement: ${definition.title}. ${isUnlocked ? "Unlocked." : "In progress: ${(progressPercentage * 100).toInt()}%."}',
      child: SoteriaCard(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(SoteriaSpacing.sm),
              decoration: BoxDecoration(
                color: isUnlocked 
                  ? SoteriaColors.gold.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.03),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(definition.icon),
                color: isUnlocked ? SoteriaColors.gold : SoteriaColors.muted,
                size: 24.sp,
              ),
            ),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    definition.title,
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isUnlocked ? SoteriaColors.textPrimary : SoteriaColors.muted,
                    ),
                  ),
                  Text(
                    definition.description,
                    style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                  ),
                  if (!isUnlocked) ...[
                    SizedBox(height: 8.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: progressPercentage,
                        backgroundColor: Colors.white10,
                        valueColor: const AlwaysStoppedAnimation(SoteriaColors.primary),
                        minHeight: 2,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isUnlocked)
              Icon(
                Icons.check_circle_rounded,
                color: SoteriaColors.success,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String iconName) {
     switch (iconName) {
      case 'stars_rounded': return Icons.stars_rounded;
      case 'military_tech_rounded': return Icons.military_tech_rounded;
      case 'workspace_premium_rounded': return Icons.workspace_premium_rounded;
      case 'local_fire_department_rounded': return Icons.local_fire_department_rounded;
      case 'bolt_rounded': return Icons.bolt_rounded;
      case 'trending_up_rounded': return Icons.trending_up_rounded;
      case 'shield_rounded': return Icons.shield_rounded;
      case 'play_arrow_rounded': return Icons.play_arrow_rounded;
      case 'sports_esports_rounded': return Icons.sports_esports_rounded;
      case 'emoji_events_rounded': return Icons.emoji_events_rounded;
      case 'psychology_rounded': return Icons.psychology_rounded;
      case 'auto_awesome_rounded': return Icons.auto_awesome_rounded;
      default: return Icons.help_outline_rounded;
    }
  }
}
