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
            // Left: Avatar and Level
            SoteriaScaleIn(
              duration: const Duration(milliseconds: 700),
              delay: const Duration(milliseconds: 200),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () => nav.go('/app/profile'),
                    child: Hero(
                      tag: 'player_avatar',
                      child: SoteriaAvatar(
                      isOnline: isOnline,
                      showStatus: true,
                      size: 64.r,
                      showGlow: true,
                      imageUrl: avatarUrl,
                    ),
                    ),
                  ),
                  Positioned(
                    bottom: -28.h,
                    left: 0,
                    child: SoteriaScaleIn(
                      duration: const Duration(milliseconds: 700),
                      delay: const Duration(milliseconds: 400),
                      child: _HeaderBadge(
                        label: 'LEVEL $level',
                        icon: Icons.auto_awesome_rounded,
                        color: SoteriaColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Middle: Greeting and Name
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
                        fontSize: 14.sp,
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
                              fontSize: 22.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text('👋', style: TextStyle(fontSize: 18.sp)),
                      ],
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
                  SizedBox(width: 12.w),
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
        IconButton(
          onPressed: nav.playChallenges,
          icon: Image.asset(
            'assets/icons/flash_icon.png',
            width: 24.sp,
            height: 24.sp,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        if (incomingCount > 0)
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: SoteriaColors.error, shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Center(
                child: Text(
                  incomingCount.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: badgeColor.withValues(alpha: 0.4),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10.sp, color: Colors.white),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 9.sp,
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
            fontSize: 18.sp,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (assetPath != null)
              Image.asset(
                assetPath!,
                width: 20.sp,
                height: 20.sp,
                fit: BoxFit.contain,
              )
            else if (icon != null)
              Icon(icon, size: 20.sp, color: color),
            SizedBox(width: 2.w),
            Text(
              label,
              style: context.labelSmall.copyWith(
                color: SoteriaColors.textSecondary.withValues(alpha: 0.7),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
