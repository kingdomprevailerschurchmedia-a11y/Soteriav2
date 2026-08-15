import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../../../player/providers/player_providers.dart';
import '../providers/matchmaking_providers.dart';
import '../../../dashboard/presentation/widgets/lobby/lobby_config_widgets.dart';
import '../widgets/versus_config_selectors.dart';
import '../widgets/matchmaking_rank_card.dart';
import '../../../player/presentation/widgets/presence/recent_opponents_section.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../player/presentation/providers/rank_providers.dart';

class VersusLobbyScreen extends ConsumerWidget {
  const VersusLobbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(versusLobbyProvider);
    final player = ref.watch(currentPlayerProvider);

    return SoteriaPage(
      isLoading: state.isLoading,
      error: state.error,
      child: Scaffold(
        backgroundColor: SoteriaColors.background,
        body: Container(
          decoration: const BoxDecoration(
            gradient: SoteriaColors.backgroundGradient,
          ),
          child: SafeArea(
            child: Column(
              children: [
                _LobbyHeader(player: player),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.all(SoteriaSpacing.lg),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            LobbyHeroHeader(
                              part1: 'FIND',
                              part2: 'YOUR',
                              part3: 'RIVAL',
                              subtitle: "Challenge opponents and climb the competitive ladder ⚔️",
                            ),
                            SizedBox(height: SoteriaSpacing.md),
                            ref.watch(rankProgressProvider).when(
                              data: (rank) => MatchmakingRankCard(
                                rankName: rank.currentRank,
                                tier: rank.tier.name,
                                points: rank.currentRP,
                              ),
                              loading: () => const SizedBox.shrink(),
                              error: (_, __) => const SizedBox.shrink(),
                            ),
                            SizedBox(height: SoteriaSpacing.lg),
                            LobbyInterestsCard(
                              value: state.useInterests,
                              onChanged: (val) => ref
                                  .read(versusLobbyProvider.notifier)
                                  .setUseInterests(val),
                            ),
                            SizedBox(height: SoteriaSpacing.md),
                            if (!state.useInterests) ...[
                              const VersusCategorySelector(),
                              SizedBox(height: SoteriaSpacing.lg),
                            ],
                            const VersusDifficultySelector(),
                            SizedBox(height: SoteriaSpacing.md),
                            const VersusQuestionCountSelector(),
                            SizedBox(height: SoteriaSpacing.lg),
                            const RecentOpponentsSection(),
                            SizedBox(height: SoteriaSpacing.lg),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                LobbyStartAction(
                  enabled: state.useInterests || state.category != null,
                  label: 'FIND OPPONENT',
                  helperText: 'Competitive Integrity • Professional Matchmaking',
                  onStart: () async {
                    List<String> categoryIds = [];
                    if (state.useInterests) {
                      final profile = ref.read(currentPlayerProvider);
                      categoryIds = profile?.favoriteCategories ?? [];
                    } else if (state.category != null) {
                      categoryIds = [state.category!.id];
                    }

                    await ref.read(matchmakingControllerProvider.notifier).enterQueue(
                      configuration: {
                        'categoryIds': categoryIds,
                        'categoryId': categoryIds.isNotEmpty ? categoryIds.first : null,
                        'categoryName': state.useInterests ? 'Interests' : state.category?.name,
                        'difficulty': state.difficulty.name,
                        'questionCount': state.questionCount,
                        'useInterests': state.useInterests,
                      },
                    );
                    if (context.mounted) {
                      context.push('/app/matchmaking');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LobbyHeader extends StatelessWidget {
  const _LobbyHeader({this.player});
  final dynamic player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 16,
              ),
              onPressed: () => context.pop(),
            ),
          ),
          const Spacer(),
          if (player != null)
            SoteriaAvatar(
              imageUrl: player.photoUrl,
              size: 40,
              isOnline: true,
            ),
        ],
      ),
    );
  }
}
