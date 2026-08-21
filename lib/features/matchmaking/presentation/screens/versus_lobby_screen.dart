import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/components/soteria_back_button.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../../../player/providers/player_providers.dart';
import '../providers/matchmaking_providers.dart';
import '../../../dashboard/presentation/widgets/lobby/lobby_config_widgets.dart';
import '../widgets/versus_config_selectors.dart';
import '../widgets/matchmaking_rank_card.dart';
import '../../../player/presentation/widgets/presence/recent_opponents_section.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/network/providers/connectivity_providers.dart';
import '../../../player/presentation/providers/rank_providers.dart';

class VersusLobbyScreen extends ConsumerWidget {
  const VersusLobbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(versusLobbyProvider);
    final player = ref.watch(currentPlayerProvider);
    final isOnline = ref.watch(isOnlineProvider);

    final fromDashboard =
        GoRouterState.of(context).uri.queryParameters['fromDashboard'] == 'true';

    return SoteriaPage(
      isLoading: state.isLoading,
      error: state.error,
      useSafeArea: false,
      showBackground: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              _LobbyHeader(
                player: player,
                isOnline: isOnline,
                showBackButton: fromDashboard,
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.all(SoteriaSpacing.lg),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const LobbyHeroHeader(
                            part1: 'FIND',
                            part2: 'YOUR',
                            part3: 'RIVAL',
                            subtitle:
                                "Challenge opponents and climb the competitive ladder ⚔️",
                          ),
                          SizedBox(height: SoteriaSpacing.md),
                          ref.watch(rankProgressProvider).when(
                                data: (rank) => MatchmakingRankCard(
                                  rankName: rank.currentRank,
                                  tier: rank.tier.name,
                                  points: rank.currentRP,
                                ),
                                loading: () => const SizedBox.shrink(),
                                error: (_, _) => const SizedBox.shrink(),
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
                enabled: state.validationError == null,
                error: state.validationError,
                label: 'FIND OPPONENT',
                helperText: 'Competitive Integrity • Professional Matchmaking',
                onStart: () async {
                  List<String> categoryIds = [];
                  if (state.useInterests) {
                    final profile = ref.read(currentPlayerProvider);
                    categoryIds = profile?.favoriteCategories ?? [];
                  } else {
                    categoryIds = state.categoryIds;
                  }

                  await ref
                      .read(matchmakingControllerProvider.notifier)
                      .enterQueue(
                    configuration: {
                      'categoryIds': categoryIds,
                      'categoryId':
                          categoryIds.isNotEmpty ? categoryIds.first : null,
                      'categoryName': state.useInterests
                          ? 'Interests'
                          : (categoryIds.length == 1
                              ? state.categories
                                  .firstWhere((c) => c.id == categoryIds.first)
                                  .name
                              : '${categoryIds.length} Categories'),
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
    );
  }
}

class _LobbyHeader extends StatelessWidget {
  const _LobbyHeader({
    this.player,
    required this.isOnline,
    this.showBackButton = false,
  });
  final dynamic player;
  final bool isOnline;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Row(
        children: [
          if (showBackButton)
            const SoteriaBackButton()
          else
            const SizedBox.shrink(),
          const Spacer(),
          if (player != null)
            SoteriaAvatar(
              imageUrl: player.photoUrl,
              size: 40,
              isOnline: isOnline,
              showStatus: true,
            ),
        ],
      ),
    );
  }
}
