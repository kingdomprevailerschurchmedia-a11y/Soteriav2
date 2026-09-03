import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/components/soteria_back_button.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
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
    final matchmakingState = ref.watch(matchmakingControllerProvider);

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
                            _DiscoveryStatusCard(
                              isSearchable: player?.allowVersusChallenges ?? true,
                              onToggle: (val) async {
                                if (player != null) {
                                  await ref.read(playerRepositoryProvider).patchPlayerProfile(
                                    player.uid,
                                    {'allowVersusChallenges': val},
                                  );
                                }
                              },
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
                  isLoading: matchmakingState.isLoading,
                  error: state.validationError ?? matchmakingState.error?.toString(),
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

                    await ref.read(matchmakingControllerProvider.notifier).enterQueue(
                      configuration: {
                        'categoryIds': categoryIds,
                        'categoryId': categoryIds.isNotEmpty ? categoryIds.first : null,
                        'categoryName': state.useInterests 
                            ? 'Interests' 
                            : (categoryIds.length == 1 
                                ? state.categories.firstWhere((c) => c.id == categoryIds.first).name 
                                : '${categoryIds.length} Categories'),
                        'difficulty': state.difficulty.name,
                        'questionCount': state.questionCount,
                        'useInterests': state.useInterests,
                      },
                    );
                    
                    if (context.mounted && !ref.read(matchmakingControllerProvider).hasError) {
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

class _DiscoveryStatusCard extends StatelessWidget {
  final bool isSearchable;
  final ValueChanged<bool> onToggle;

  const _DiscoveryStatusCard({
    required this.isSearchable,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isSearchable 
            ? SoteriaColors.success.withValues(alpha: 0.05)
            : SoteriaColors.warning.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSearchable 
              ? SoteriaColors.success.withValues(alpha: 0.2)
              : SoteriaColors.warning.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: isSearchable 
                  ? SoteriaColors.success.withValues(alpha: 0.1)
                  : SoteriaColors.warning.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isSearchable ? Icons.visibility_rounded : Icons.visibility_off_rounded,
              color: isSearchable ? SoteriaColors.success : SoteriaColors.warning,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSearchable ? 'OPEN FOR CHALLENGES' : 'PRIVATE MODE',
                  style: context.labelSmall.copyWith(
                    color: isSearchable ? SoteriaColors.success : SoteriaColors.warning,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  isSearchable 
                      ? 'Other players can find and invite you'
                      : 'You won\'t appear in search results',
                  style: context.bodySmall.copyWith(
                    color: Colors.white60,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: isSearchable,
              onChanged: onToggle,
              activeTrackColor: SoteriaColors.success.withValues(alpha: 0.5),
              activeColor: SoteriaColors.success,
            ),
          ),
        ],
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
