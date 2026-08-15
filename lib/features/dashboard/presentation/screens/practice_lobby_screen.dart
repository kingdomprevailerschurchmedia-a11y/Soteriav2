import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';
import 'package:soteria/shared/widgets/soteria_page.dart';
import 'package:soteria/features/dashboard/presentation/providers/practice_lobby_providers.dart';
import 'package:soteria/features/dashboard/presentation/widgets/lobby/category_selector.dart';
import 'package:soteria/features/dashboard/presentation/widgets/lobby/config_selectors.dart';
import 'package:soteria/features/dashboard/presentation/widgets/lobby/session_summary_card.dart';
import 'package:soteria/features/dashboard/presentation/widgets/lobby/lobby_config_widgets.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/player/presentation/providers/progression_providers.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/features/gameplay_engine/models/practice_session_config.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';

class PracticeLobbyScreen extends ConsumerWidget {
  const PracticeLobbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(practiceLobbyProvider);
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
                        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            LobbyHeroHeader(
                              part1: 'READY',
                              part2: 'TO',
                              part3: 'TRAIN?',
                              subtitle: "Let's build your knowledge and climb the ranks 🚀",
                            ),
                            SizedBox(height: SoteriaSpacing.md),
                            LobbyInterestsCard(
                              value: state.config.useInterests,
                              onChanged: (val) => ref.read(practiceLobbyProvider.notifier).setUseInterests(val),
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
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg, vertical: SoteriaSpacing.md),
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
                Stack(
                  children: [
                    SoteriaAvatar(
                      imageUrl: player.photoUrl,
                      size: 44,
                      isOnline: true,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: SoteriaColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(color: SoteriaColors.background, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
