import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/shared/widgets/soteria_page.dart';
import 'package:soteria/features/dashboard/presentation/providers/practice_lobby_providers.dart';
import 'package:soteria/features/dashboard/presentation/widgets/lobby/category_selector.dart';
import 'package:soteria/features/dashboard/presentation/widgets/lobby/config_selectors.dart';
import 'package:soteria/features/dashboard/presentation/widgets/lobby/session_summary_card.dart';
import 'package:soteria/features/dashboard/presentation/widgets/lobby/lobby_config_widgets.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/player/presentation/providers/progression_providers.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/design_system/components/soteria_back_button.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/network/providers/connectivity_providers.dart';

class PracticeLobbyScreen extends ConsumerWidget {
  const PracticeLobbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(practiceLobbyProvider);
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
                          padding: EdgeInsets.symmetric(
                            horizontal: SoteriaSpacing.lg,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              LobbyHeroHeader(
                                part1: 'READY',
                                part2: 'TO',
                                part3: 'TRAIN?',
                                subtitle:
                                    "Let's build your knowledge and climb the ranks 🚀",
                              ),
                              SizedBox(height: SoteriaSpacing.md),
                              LobbyInterestsCard(
                                value: state.config.useInterests,
                                onChanged:
                                    (val) => ref
                                        .read(practiceLobbyProvider.notifier)
                                        .setUseInterests(val),
                              ),
                              SizedBox(height: SoteriaSpacing.md),
                              if (!state.config.useInterests) ...[
                                const CategorySelector(),
                                SizedBox(height: SoteriaSpacing.lg),
                              ],
                              const DifficultySelector(),
                              SizedBox(height: SoteriaSpacing.md),
                              const QuestionCountSelector(),
                              SizedBox(height: SoteriaSpacing.lg),
                              if (state.estimatedRewards != null)
                                SessionSummaryCard(
                                  rewards: state.estimatedRewards!,
                                ),
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
                    label: 'START PRACTICE',
                    helperText: 'Earn XP • Improve • Climb the leaderboard',
                    onStart: () async {
                      final session = await ref
                          .read(practiceLobbyProvider.notifier)
                          .startSession();
                      if (session != null && context.mounted) {
                        context.push(SoteriaRoutes.practiceSession);
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
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.lg,
        vertical: SoteriaSpacing.md,
      ),
      child: Row(
        children: [
          if (showBackButton)
            const SoteriaBackButton()
          else
            const SizedBox.shrink(),
          const Spacer(),
          if (player != null)
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      player.displayName,
                      style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final level = ref.watch(currentCompetitiveLevelProvider);
                        return Text(
                          'Lvl $level',
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.gold,
                            fontWeight: FontWeight.w900,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(width: SoteriaSpacing.md),
                SoteriaAvatar(
                  imageUrl: player.photoUrl,
                  size: 44,
                  isOnline: isOnline,
                  showStatus: true,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
