import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../player/presentation/providers/achievement_providers.dart';
import '../../../player/domain/models/achievement.dart';
import '../../../player/domain/services/achievement_registry.dart';
import '../../../../core/navigation/soteria_routes.dart';

class RecentAchievementsSection extends ConsumerWidget {
  const RecentAchievementsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentAchievements = ref.watch(recentAchievementsProvider);
    final definitions = ref.watch(achievementDefinitionsProvider);
    final earnedMap = ref.watch(playerAchievementMapProvider);

    // Show top 3 achievements (unlocked first, then locked by order)
    final displayList = _getDisplayList(definitions, earnedMap);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/recent_achievement.png',
                    width: 24.w,
                    height: 24.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'RECENT ACHIEVEMENTS',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.gold,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => context.push(SoteriaRoutes.achievements),
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.muted,
                        fontWeight: FontWeight.w900,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: SoteriaColors.muted,
                      size: 18.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SizedBox(
          height: 165.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            physics: const BouncingScrollPhysics(),
            itemCount: displayList.length,
            itemBuilder: (context, index) {
              final item = displayList[index];
              return _AchievementCard(
                title: item.def.title,
                description: item.def.description,
                date: item.unlockedAt != null ? _formatDate(item.unlockedAt!) : '',
                color: _getCategoryColor(item.def.category),
                isUnlocked: item.isUnlocked,
                icon: _getIcon(item.def.icon),
                currentProgress: item.currentValue.toInt(),
                totalProgress: item.def.threshold.toInt(),
              );
            },
          ),
        ),
      ],
    );
  }

  List<_AchievementDisplayItem> _getDisplayList(
    List<AchievementDefinition> definitions,
    Map<String, PlayerAchievement> earnedMap,
  ) {
    final list = <_AchievementDisplayItem>[];
    
    // First, add all earned achievements, sorted by date
    final earned = earnedMap.values.toList()
      ..sort((a, b) => (b.unlockedAt ?? DateTime(0)).compareTo(a.unlockedAt ?? DateTime(0)));
    
    for (final ach in earned) {
      final def = AchievementRegistry.getById(ach.achievementId);
      if (def != null) {
        list.add(_AchievementDisplayItem(
          def: def,
          isUnlocked: true,
          unlockedAt: ach.unlockedAt,
          currentValue: ach.currentValue,
        ));
      }
    }

    // Then, add locked achievements by display order
    final locked = definitions.where((d) => !earnedMap.containsKey(d.id)).toList()
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    
    for (final def in locked) {
      list.add(_AchievementDisplayItem(
        def: def,
        isUnlocked: false,
        currentValue: 0, // In a real app, we might track progress even if locked
      ));
    }

    return list.take(10).toList();
  }

  String _formatDate(DateTime date) {
    return '${_getMonth(date.month)} ${date.day}, ${date.year}';
  }

  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  Color _getCategoryColor(AchievementCategory category) {
    switch (category) {
      case AchievementCategory.victory:
        return SoteriaColors.gold;
      case AchievementCategory.streak:
        return SoteriaColors.warning;
      case AchievementCategory.special:
        return const Color(0xFF7C4DFF);
      default:
        return SoteriaColors.primary;
    }
  }

  Widget _getIcon(String iconName) {
    IconData iconData;
    switch (iconName) {
      case 'stars_rounded':
        iconData = Icons.stars_rounded;
      case 'psychology_rounded':
        iconData = Icons.psychology_rounded;
      case 'emoji_events_rounded':
        iconData = Icons.emoji_events_rounded;
      case 'military_tech_rounded':
        iconData = Icons.military_tech_rounded;
      case 'workspace_premium_rounded':
        iconData = Icons.workspace_premium_rounded;
      case 'local_fire_department_rounded':
        iconData = Icons.local_fire_department_rounded;
      case 'bolt_rounded':
        iconData = Icons.bolt_rounded;
      case 'trending_up_rounded':
        iconData = Icons.trending_up_rounded;
      case 'shield_rounded':
        iconData = Icons.shield_rounded;
      case 'play_arrow_rounded':
        iconData = Icons.play_arrow_rounded;
      case 'sports_esports_rounded':
        iconData = Icons.sports_esports_rounded;
      case 'auto_awesome_rounded':
        iconData = Icons.auto_awesome_rounded;
      default:
        iconData = Icons.emoji_events_rounded;
    }
    return Icon(iconData, color: Colors.white, size: 24.sp);
  }
}

class _AchievementDisplayItem {
  final AchievementDefinition def;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final double currentValue;

  _AchievementDisplayItem({
    required this.def,
    required this.isUnlocked,
    this.unlockedAt,
    required this.currentValue,
  });
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({
    required this.title,
    required this.description,
    required this.date,
    required this.color,
    required this.isUnlocked,
    required this.icon,
    this.currentProgress = 0,
    this.totalProgress = 100,
  });

  final String title;
  final String description;
  final String date;
  final Color color;
  final bool isUnlocked;
  final Widget icon;
  final int currentProgress;
  final int totalProgress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165.w,
      margin: EdgeInsets.only(right: 12.w),
      child: SoteriaCard(
        padding: EdgeInsets.zero,
        borderRadius: 24,
        borderColor: isUnlocked ? color.withValues(alpha: 0.3) : null,
        child: Container(
          decoration: BoxDecoration(
            gradient: isUnlocked
                ? RadialGradient(
                    center: Alignment.topCenter,
                    radius: 1.2,
                    colors: [color.withValues(alpha: 0.15), Colors.transparent],
                  )
                : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Subtle background stars/decoration if unlocked
              if (isUnlocked)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _StarsPainter(color: color.withValues(alpha: 0.3)),
                  ),
                ),

              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Achievement Icon
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        gradient: isUnlocked
                            ? LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  color.withValues(alpha: 0.2),
                                  color.withValues(alpha: 0.05),
                                ],
                              )
                            : null,
                        color: isUnlocked
                            ? null
                            : Colors.white.withValues(alpha: 0.03),
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (isUnlocked)
                            BoxShadow(
                              color: color.withValues(alpha: 0.2),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: Center(
                        child: isUnlocked
                            ? icon
                            : Icon(
                                Icons.lock_rounded,
                                color: SoteriaColors.muted.withValues(alpha: 0.5),
                                size: 22.sp,
                              ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // Title
                    Text(
                      title,
                      style: context.bodyLarge.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    // Description
                    Text(
                      description,
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.muted,
                        fontSize: 10.sp,
                        height: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),

                    // Bottom Section: Date or Progress
                    if (isUnlocked)
                      _DateBadge(date: date, color: color)
                    else
                      _ProgressBar(
                        current: currentProgress,
                        total: totalProgress,
                        color: const Color(0xFF7C4DFF),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date, required this.color});
  final String date;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline_rounded, color: color, size: 12.sp),
          SizedBox(width: 4.w),
          Text(
            date,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.textSecondary,
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.current,
    required this.total,
    required this.color,
  });
  final int current;
  final int total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final progress = (current / total).clamp(0.0, 1.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              height: 4.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              height: 4.h,
              width: 80.w * progress,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.5)],
                ),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 4),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          '$current / $total',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 9.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _StarsPainter extends CustomPainter {
  _StarsPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final points = [
      Offset(size.width * 0.15, size.height * 0.25),
      Offset(size.width * 0.85, size.height * 0.35),
      Offset(size.width * 0.2, size.height * 0.45),
      Offset(size.width * 0.8, size.height * 0.15),
      Offset(size.width * 0.5, size.height * 0.1),
    ];

    for (var p in points) {
      canvas.drawCircle(p, 1.2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
