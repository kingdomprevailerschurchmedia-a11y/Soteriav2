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
    required this.coins,
    required this.profileCompletion,
    this.avatarUrl,
    this.isOnline = true,
  });

  final String greeting;
  final String playerName;
  final int level;
  final int streak;
  final int coins;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      _CompactStat(
                        icon: Icons.local_fire_department_rounded,
                        value: streak.toString(),
                        label: 'Day Streak',
                        color: Colors.orange,
                      ),
                      SizedBox(width: SoteriaSpacing.md),
                      _CompactStat(
                        icon: Icons.monetization_on_rounded,
                        value: coins.toString(),
                        label: 'Coins',
                        color: SoteriaColors.gold,
                      ),
                    ],
                  ),
                  SizedBox(height: SoteriaSpacing.md),
                  GestureDetector(
                    onTap: () => nav.go('/app/profile'),
                    child: Hero(
                      tag: 'player_avatar',
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: SoteriaColors.primary.withValues(alpha: 0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: SoteriaColors.primary.withValues(
                                alpha: 0.2,
                              ),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: SoteriaAvatar(
                          url: avatarUrl,
                          isOnline: isOnline,
                          size: 56,
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: color),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
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
      children: [
        Row(
          children: [
            Icon(icon, size: 18.sp, color: color),
            SizedBox(width: 4.w),
            Text(
              value,
              style: context.titleMedium.copyWith(
                fontWeight: FontWeight.w900,
                color: SoteriaColors.textPrimary,
              ),
            ),
          ],
        ),
        Text(
          label,
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
