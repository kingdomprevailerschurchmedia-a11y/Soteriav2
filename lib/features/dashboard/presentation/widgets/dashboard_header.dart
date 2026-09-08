import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/navigation/providers/navigation_providers.dart';
import '../../../../core/navigation/soteria_routes.dart';
import '../../../player/presentation/providers/challenge_providers.dart';

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
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.containerPadding(context),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Avatar
            SoteriaScaleIn(
              duration: const Duration(milliseconds: 700),
              delay: const Duration(milliseconds: 200),
              child: GestureDetector(
                onTap: () => nav.go('/app/profile'),
                child: Hero(
                  tag: 'player_avatar',
                  child: SoteriaAvatar(
                    isOnline: isOnline,
                    showStatus: true,
                    size: 54.r,
                    showGlow: true,
                    imageUrl: avatarUrl,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            // Middle: Greeting, Name and Level
            Expanded(
              child: SoteriaSlideLeft(
                duration: const Duration(milliseconds: 600),
                offset: 10.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      greeting,
                      style: context.labelSmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            playerName,
                            style: context.displaySmall.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                              fontSize: 17.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text('👋', style: TextStyle(fontSize: 14.sp)),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    _HeaderBadge(
                      label: 'LEVEL $level',
                      icon: Icons.auto_awesome_rounded,
                      color: SoteriaColors.primary,
                    ),
                  ],
                ),
              ),
            ),
            // Right: Stats and Action
            SoteriaScaleIn(
              duration: const Duration(milliseconds: 700),
              delay: const Duration(milliseconds: 300),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: nav.openWallet,
                    child: _CompactStat(
                      assetPath: 'assets/icons/coin_icon.png',
                      value: coins.toString(),
                      label: 'Coins',
                    ),
                  ),
                  SizedBox(width: 16.w),
                  _ChallengesAction(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChallengesAction extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomingCount = ref.watch(incomingChallengesProvider).value?.length ?? 0;
    final nav = ref.watch(navigationCoordinatorProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: nav.playChallenges,
          child: Container(
            width: 54.r,
            height: 54.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
              border: Border.all(
                color: SoteriaColors.primary.withValues(alpha: 0.2),
                width: 2.w,
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/flash_icon.png',
                width: 26.r,
                height: 26.r,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        if (incomingCount > 0)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: const BoxDecoration(
                color: SoteriaColors.error,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(
                minWidth: 20.r,
                minHeight: 20.r,
              ),
              child: Center(
                child: Text(
                  incomingCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
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
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.4),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: badgeColor.withValues(alpha: 0.4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 8.sp, color: Colors.white),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 7.5.sp,
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
    this.assetPath,
    required this.value,
    required this.label,
    this.icon,
    this.color,
  });

  final IconData? icon;
  final String? assetPath;
  final String value;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          value,
          style: context.headlineMedium.copyWith(
            fontWeight: FontWeight.w900,
            color: SoteriaColors.textPrimary,
            fontSize: 16.sp,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (assetPath != null)
              Image.asset(
                assetPath!,
                width: 16.sp,
                height: 16.sp,
                fit: BoxFit.contain,
              )
            else if (icon != null)
              Icon(icon, size: 16.sp, color: color),
            SizedBox(width: 2.w),
            Text(
              label,
              style: context.labelSmall.copyWith(
                color: SoteriaColors.textSecondary.withValues(alpha: 0.7),
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
