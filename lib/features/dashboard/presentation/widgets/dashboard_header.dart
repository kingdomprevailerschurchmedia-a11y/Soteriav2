import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/design_system/components/soteria_avatar.dart';
import '../../../../core/navigation/providers/navigation_providers.dart';

class DashboardHeader extends ConsumerWidget {
  const DashboardHeader({
    super.key,
    required this.greeting,
    required this.playerName,
    required this.level,
    required this.streak,
    required this.profileCompletion,
    this.avatarUrl,
    this.isOnline = true,
  });

  final String greeting;
  final String playerName;
  final int level;
  final int streak;
  final double profileCompletion;
  final String? avatarUrl;
  final bool isOnline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = ref.watch(navigationCoordinatorProvider);

    return Semantics(
      header: true,
      label: 'Dashboard Header. Player: $playerName. Level: $level',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SoteriaSlideLeft(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.gold,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            playerName,
                            style: context.displaySmall.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1.0,
                              fontSize: 36.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text('👋', style: TextStyle(fontSize: 24.sp)),
                      ],
                    ),
                    SizedBox(height: SoteriaSpacing.md),
                    Row(
                      children: [
                        _HeaderBadge(
                          label: 'LEVEL $level',
                          icon: Icons.auto_awesome_rounded,
                          color: SoteriaColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SoteriaScaleIn(
              duration: const Duration(milliseconds: 700),
              delay: const Duration(milliseconds: 300),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _CompactStat(
                    icon: Icons.local_fire_department_rounded,
                    value: streak.toString(),
                    label: 'Day Streak',
                    color: Colors.orange,
                  ),
                  SizedBox(width: SoteriaSpacing.md),
                  GestureDetector(
                    onTap: () => nav.go('/app/profile'),
                    child: Hero(
                      tag: 'player_avatar',
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              SoteriaColors.primary.withValues(alpha: 0.6),
                              SoteriaColors.primary.withValues(alpha: 0.0),
                            ],
                            stops: const [0.7, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: SoteriaColors.primary.withValues(
                                alpha: 0.4,
                              ),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: SoteriaAvatar(
                          url: avatarUrl,
                          isOnline: isOnline,
                          size: 60,
                          hasBorder: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderBadge extends StatelessWidget {
  const _HeaderBadge({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final badgeColor = SoteriaColors.primary;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: Colors.white),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 11.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactStat extends StatelessWidget {
  const _CompactStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24.sp, color: color),
            SizedBox(width: 8.w),
            Text(
              value,
              style: context.headlineMedium.copyWith(
                fontWeight: FontWeight.w900,
                color: SoteriaColors.textPrimary,
                fontSize: 28.sp,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.textSecondary.withValues(alpha: 0.7),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
