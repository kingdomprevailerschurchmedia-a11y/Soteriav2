import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/gradients/soteria_gradients.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/widgets/animations/animated_numeric_counter.dart';
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
          children: [
            Expanded(
              child: SoteriaSlideLeft(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          greeting.toUpperCase(),
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.gold,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: nav.openSettings,
                          child: Semantics(
                            label: 'Settings',
                            button: true,
                            child: const Icon(
                              Icons.settings_rounded,
                              color: SoteriaColors.muted,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      playerName,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: SoteriaSpacing.xs),
                    Row(
                      children: [
                        _HeaderBadge(
                          label: 'LEVEL $level',
                          icon: Icons.auto_awesome_rounded,
                          color: SoteriaColors.primary,
                        ),
                        SizedBox(width: SoteriaSpacing.sm),
                        _HeaderBadge(
                          label:
                              '${(profileCompletion * 100).toInt()}% COMPLETE',
                          icon: Icons.verified_user_rounded,
                          color: SoteriaColors.muted,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SoteriaScaleIn(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: Row(
                children: [
                  _StreakCounter(streak: streak),
                  SizedBox(width: SoteriaSpacing.md),
                  Stack(
                    children: [
                      _ProfileAvatar(
                        url: avatarUrl,
                        isOnline: isOnline,
                        onTap: () => nav.go('/app/profile'),
                      ),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: IconButton(
                          onPressed: nav.openNotifications,
                          icon: const Icon(
                            Icons.notifications_rounded,
                            color: SoteriaColors.gold,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(SoteriaRadius.full),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakCounter extends StatelessWidget {
  const _StreakCounter({required this.streak});
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Current streak: $streak days',
      child: Column(
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            color: Colors.orange,
            size: 24,
          ),
          AnimatedNumericCounter(
            value: streak,
            style: context.bodySmall.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({this.url, required this.isOnline, this.onTap});
  final String? url;
  final bool isOnline;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Semantics(
        label: 'User Avatar. Status: ${isOnline ? 'Online' : 'Offline'}',
        button: true,
        child: Stack(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 2,
                ),
                gradient: SoteriaGradients.competition,
              ),
              child: ClipOval(
                child: url != null && url!.isNotEmpty
                    ? Image.network(url!, fit: BoxFit.cover)
                    : const Center(
                        child: Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
              ),
            ),
            Positioned(
              right: 2,
              bottom: 2,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: isOnline ? Colors.greenAccent : Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(color: SoteriaColors.background, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
