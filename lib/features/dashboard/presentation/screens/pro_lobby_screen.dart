import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../../../player/providers/player_providers.dart';
import '../../../../features/gameplay_engine/models/pro_session_config.dart';
import '../providers/pro_lobby_providers.dart';
import '../widgets/lobby/lobby_config_widgets.dart';
import '../widgets/lobby/pro/pro_session_summary_card.dart';
import '../widgets/lobby/pro/pro_entry_fee_widget.dart';
import '../widgets/lobby/pro/pro_confirmation_dialog.dart';
import '../widgets/lobby/pro/competitive_badge.dart';
import '../../../../features/tournaments/domain/models/tournament.dart';
import '../../../../features/gameplay_engine/models/pro_mode_access.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import '../widgets/lobby/lobby_config_widgets.dart';

class ProLobbyScreen extends ConsumerWidget {
  final Tournament? tournament;
  const ProLobbyScreen({super.key, this.tournament});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(proLobbyProvider);
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
            child: Stack(
              children: [
                Column(
                  children: [
                    _ProHeader(player: player),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                SoteriaFadeIn(
                                  duration: SoteriaAnimations.medium,
                                  child: Semantics(
                                    header: true,
                                    label: 'Pro Mode Lobby',
                                    child: const LobbyHeroHeader(
                                      part1: 'PRO',
                                      part2: 'MODE',
                                      part3: 'CHALLENGE',
                                      subtitle: "High stakes. Professional integrity. Rank points at risk.",
                                    ),
                                  ),
                                ),
                                SizedBox(height: SoteriaSpacing.md),
                                if (state.access.state == ProModeAccessState.locked)
                                  _LockedStateCard(message: state.access.message)
                                else ...[
                                  const ProEntryFeeWidget(),
                                  SizedBox(height: SoteriaSpacing.md),
                                  LobbyInterestsCard(
                                    value: state.config.useInterests,
                                    onChanged: (val) => ref
                                        .read(proLobbyProvider.notifier)
                                        .setUseInterests(val),
                                  ),
                                  SizedBox(height: SoteriaSpacing.md),
                                  const DifficultySelectorSection(),
                                  SizedBox(height: SoteriaSpacing.md),
                                  const QuestionCountSelectorSection(),
                                  SizedBox(height: SoteriaSpacing.lg),
                                  const ProSessionSummaryCard(),
                                ],
                                SizedBox(height: SoteriaSpacing.lg),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    LobbyStartAction(
                      enabled: state.access.isAllowed,
                      error: _getErrorMessage(state.access),
                      label: 'INITIALIZE SESSION',
                      helperText: 'Authoritative Validation • Secure Settlement',
                      onStart: () {
                        showDialog(
                          context: context,
                          builder: (context) => ProEntryConfirmationDialog(
                            fee: state.config.entryFee,
                            onConfirm: () async {
                              final session = await ref
                                  .read(proLobbyProvider.notifier)
                                  .startSession();
                              if (session != null && context.mounted) {
                                // Navigate to Game
                                context.push(SoteriaRoutes.proGameplay, extra: session);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                if (state.isOffline)
                  _OfflineOverlay(
                    onRetry: () =>
                        ref.read(proLobbyProvider.notifier).checkConnection(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _getErrorMessage(ProModeAccessResult access) {
    switch (access.state) {
      case ProModeAccessState.insufficientTokens:
        return 'INSUFFICIENT COINS';
      case ProModeAccessState.insufficientContent:
        return access.message?.toUpperCase() ?? 'NOT ENOUGH QUESTIONS AVAILABLE';
      case ProModeAccessState.locked:
        return access.message?.toUpperCase();
      default:
        return null;
    }
  }
}

class _LockedStateCard extends StatelessWidget {
  final String? message;
  const _LockedStateCard({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.xl),
      decoration: BoxDecoration(
        color: SoteriaColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(SoteriaRadius.lg),
        border: Border.all(color: SoteriaColors.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          const Icon(Icons.lock_person_rounded, color: SoteriaColors.error, size: 48),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            'PRO MODE LOCKED',
            style: context.titleMedium.copyWith(color: SoteriaColors.error, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: SoteriaSpacing.sm),
          Text(
            message ?? 'Increase your level to unlock Pro Mode.',
            style: context.bodySmall.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _OfflineOverlay extends StatelessWidget {
  final VoidCallback onRetry;
  const _OfflineOverlay({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SoteriaColors.background.withValues(alpha: 0.95),
      padding: EdgeInsets.all(SoteriaSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cloud_off_rounded,
            color: SoteriaColors.error,
            size: 64,
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Text(
            'CONNECTION REQUIRED',
            style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            'Pro Mode requires an active internet connection to verify competitive integrity and sync coin balances.',
            style: context.bodyMedium.copyWith(
              color: SoteriaColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          SoteriaButton.primary(label: 'TRY AGAIN', onPressed: onRetry),
        ],
      ),
    );
  }
}

class _ProHeader extends StatelessWidget {
  const _ProHeader({this.player});
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
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [SoteriaColors.gold, Color(0xFFFFD700)],
                          ).createShader(bounds),
                          child: const Icon(
                            Icons.monetization_on_rounded,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${player.coins}',
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.gold,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                            fontSize: 10,
                          ),
                        ),
                      ],
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

class DifficultySelectorSection extends ConsumerWidget {
  const DifficultySelectorSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(
      proLobbyProvider.select((s) => s.config.difficulty),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LobbySectionHeader(
          label: 'DIFFICULTY',
          icon: Icons.psychology_rounded,
        ),
        SizedBox(height: SoteriaSpacing.md),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 8.w,
          crossAxisSpacing: 8.w,
          childAspectRatio: 1.1,
          children: [
            LobbyDifficultyCard(
              isSelected: current == ProDifficulty.intermediate,
              label: 'INTERMEDIATE',
              icon: Icons.bar_chart_rounded,
              color: const Color(0xFF7C4DFF),
              onTap: () => ref.read(proLobbyProvider.notifier).updateDifficulty(ProDifficulty.intermediate),
            ),
            LobbyDifficultyCard(
              isSelected: current == ProDifficulty.advanced,
              label: 'ADVANCED',
              icon: Icons.whatshot_rounded,
              color: const Color(0xFFFFAB40),
              onTap: () => ref.read(proLobbyProvider.notifier).updateDifficulty(ProDifficulty.advanced),
            ),
            LobbyDifficultyCard(
              isSelected: current == ProDifficulty.expert,
              label: 'EXPERT',
              icon: Icons.workspace_premium_rounded,
              color: const Color(0xFFFF5252),
              onTap: () => ref.read(proLobbyProvider.notifier).updateDifficulty(ProDifficulty.expert),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        LobbyAdaptiveToggle(
          isSelected: current == ProDifficulty.adaptive,
          label: 'ADAPTIVE INTELLIGENCE',
          onTap: () => ref.read(proLobbyProvider.notifier).updateDifficulty(
            current == ProDifficulty.adaptive ? ProDifficulty.intermediate : ProDifficulty.adaptive,
          ),
        ),
      ],
    );
  }
}

class QuestionCountSelectorSection extends ConsumerWidget {
  const QuestionCountSelectorSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(
      proLobbyProvider.select((s) => s.config.questionCount),
    );
    final counts = [10, 20, 30, 50];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LobbySectionHeader(
          label: 'QUESTIONS',
          icon: Icons.layers_rounded,
        ),
        SizedBox(height: SoteriaSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: counts.map((count) {
            final isSelected = current == count;
            return LobbyCountCircle(
              count: count,
              isSelected: isSelected,
              onTap: () => ref.read(proLobbyProvider.notifier).updateQuestionCount(count),
            );
          }).toList(),
        ),
      ],
    );
  }
}
