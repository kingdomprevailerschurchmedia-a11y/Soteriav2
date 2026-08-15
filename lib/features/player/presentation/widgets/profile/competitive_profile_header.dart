import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../domain/models/player_profile.dart';
import '../../../domain/models/player_progression.dart';
import '../../providers/streak_providers.dart';
import '../competitive_rank_badge.dart';
import '../streak/momentum_indicator.dart';

class CompetitiveProfileHeader extends ConsumerWidget {
  final PlayerProfile identity;
  final PlayerProgression progression;
  final int globalPosition;

  const CompetitiveProfileHeader({
    super.key,
    required this.identity,
    required this.progression,
    required this.globalPosition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final momentumAsync = ref.watch(currentMomentumProvider);

    return SoteriaCard(
      hasGlow: true,
      glowColor: SoteriaColors.primary.withValues(alpha: 0.3),
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  SoteriaAvatar(
                    imageUrl: identity.photoUrl,
                    size: 80.w,
                    hasBorder: true,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: SoteriaColors.background,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: SoteriaColors.primary.withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 14.w,
                      color: SoteriaColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(width: SoteriaSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      identity.displayName,
                      style: context.headlineSmall.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '@${identity.username}',
                      style: context.bodyMedium.copyWith(
                        color: SoteriaColors.muted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: SoteriaSpacing.md),
                    Row(
                      children: [
                        _IdentityBadge(
                          label: 'Lvl ${progression.currentLevel}',
                          color: SoteriaColors.primary,
                          icon: Icons.bolt_rounded,
                        ),
                        SizedBox(width: SoteriaSpacing.sm),
                        _IdentityBadge(
                          label: progression.currentRank.toUpperCase(),
                          color: SoteriaColors.secondary,
                          icon: Icons.emoji_events_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SoteriaSpacing.gapMD,
          const Divider(color: Colors.white10),
          SoteriaSpacing.gapMD,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RANK POINTS',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    '${progression.rankPoints} RP',
                    style: context.titleMedium.copyWith(
                      color: SoteriaColors.textPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              if (globalPosition > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'GLOBAL RANK',
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.muted,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      '#$globalPosition',
                      style: context.titleMedium.copyWith(
                        color: SoteriaColors.gold,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          momentumAsync.when(
            data: (momentum) => momentum != null
                ? Padding(
                    padding: EdgeInsets.only(top: SoteriaSpacing.md),
                    child: MomentumIndicator(momentum: momentum),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _IdentityBadge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _IdentityBadge({
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.w, color: color),
          SizedBox(width: 4.w),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
