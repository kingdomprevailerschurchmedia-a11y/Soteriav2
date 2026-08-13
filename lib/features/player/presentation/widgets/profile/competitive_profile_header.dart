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
      glowColor: SoteriaColors.primary,
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        children: [
          Row(
            children: [
              SoteriaAvatar(
                imageUrl: identity.photoUrl,
                size: 64,
                hasBorder: true,
              ),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: Semantics(
                  label: 'Player identity and rank',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        identity.displayName,
                        style: context.headlineSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            'Level ${progression.currentLevel}',
                            style: context.bodySmall.copyWith(
                              color: SoteriaColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (globalPosition > 0) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SoteriaSpacing.xs,
                              ),
                              child: Text(
                                '•',
                                style: context.bodySmall.copyWith(
                                  color: SoteriaColors.muted,
                                ),
                              ),
                            ),
                            Semantics(
                              label: 'Global ranking position',
                              child: Text(
                                '#$globalPosition GLOBAL',
                                style: context.bodySmall.copyWith(
                                  color: SoteriaColors.gold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Semantics(
                label: 'Competitive rank: ${progression.currentRank}',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CompetitiveRankBadge(
                      rankName: progression.currentRank,
                      tierId: progression.currentRankTier,
                      size: RankBadgeSize.large,
                    ),
                    SizedBox(height: SoteriaSpacing.xs),
                    Text(
                      '${progression.rankPoints} RP',
                      style: context.titleSmall.copyWith(
                        color: SoteriaColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          momentumAsync.when(
            data: (momentum) => momentum != null
                ? Padding(
                    padding: EdgeInsets.only(top: SoteriaSpacing.md),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MomentumIndicator(momentum: momentum),
                    ),
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
