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
                            SoteriaFadeIn(
                              child: Text(
                                'FIND YOUR RIVAL',
                                style: context.displayMedium.copyWith(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -1,
                                ),
                              ),
                            ),
                            SizedBox(height: SoteriaSpacing.xl),
                            ref.watch(rankProgressProvider).when(
                              data: (rank) => MatchmakingRankCard(
                                rankName: rank.currentRank,
                                tier: rank.tier.name,
                                points: rank.currentRP,
                              ),
                              loading: () => const SizedBox.shrink(),
                              error: (_, __) => const SizedBox.shrink(),
                            ),
                            SizedBox(height: SoteriaSpacing.xl),
                            const VersusCategorySelector(),
                            SizedBox(height: SoteriaSpacing.xxl),
                            const VersusDifficultySelector(),
                            SizedBox(height: SoteriaSpacing.xl),
                            const VersusQuestionCountSelector(),
                            SizedBox(height: SoteriaSpacing.xxl),
                            const RecentOpponentsSection(),
                            SizedBox(height: SoteriaSpacing.xxl),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                _SearchAction(
                  enabled: state.category != null,
                  onSearch: () async {
                    await ref.read(matchmakingControllerProvider.notifier).enterQueue(
                      configuration: {
                        'categoryId': state.category?.id,
                        'categoryName': state.category?.name,
                        'difficulty': state.difficulty.name,
                        'questionCount': state.questionCount,
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
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () => context.pop(),
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

class _SearchAction extends StatelessWidget {
  const _SearchAction({required this.enabled, required this.onSearch});
  final bool enabled;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        SoteriaSpacing.lg,
        SoteriaSpacing.lg,
        SoteriaSpacing.lg,
        SoteriaSpacing.lg + 80.h,
      ),
      decoration: BoxDecoration(
        color: SoteriaColors.surface.withValues(alpha: 0.8),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: SoteriaButton.primary(
        label: 'FIND OPPONENT',
        onPressed: enabled ? onSearch : null,
      ),
    );
  }
}
