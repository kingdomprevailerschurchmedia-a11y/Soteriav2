import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/navigation/providers/navigation_providers.dart';
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
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: SoteriaSpacing.xs),
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
                        size: 52,
                        showGlow: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                SoteriaSlideLeft(
                  duration: const Duration(milliseconds: 600),
                  offset: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting,
                        style: context.labelSmall.copyWith(
                          color: SoteriaColors.gold,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            playerName,
                            style: context.displaySmall.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1.0,
                              fontSize: 24.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text('👋', style: TextStyle(fontSize: 20.sp)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SoteriaScaleIn(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 300),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => nav.navigateTo('/app/wallet'),
                        child: _CompactStat(
                          assetPath: 'assets/icons/coin_icon.png',
                          value: coins.toString(),
                          label: 'Coins',
                        ),
                      ),
                      SizedBox(width: SoteriaSpacing.sm),
                      _ChallengesAction(),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.sm),
            Padding(
              padding: EdgeInsets.only(left: SoteriaSpacing.xs),
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
          icon: const Icon(Icons.bolt_rounded, color: SoteriaColors.gold),
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
    this.icon,
    this.assetPath,
    required this.value,
    required this.label,
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
