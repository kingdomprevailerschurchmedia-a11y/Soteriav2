import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import '../widgets/lobby/config_selectors.dart';
import '../widgets/lobby/pro/pro_reward_card.dart';
import '../widgets/lobby/pro/pro_risk_card.dart';
import '../widgets/lobby/pro/pro_entry_fee_widget.dart';
import '../widgets/lobby/pro/pro_confirmation_dialog.dart';
import '../widgets/lobby/pro/competitive_badge.dart';
import '../../../../features/tournaments/domain/models/tournament.dart';
import 'package:soteria/core/design_system/components/soteria_avatar.dart';

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
                            padding: EdgeInsets.all(SoteriaSpacing.lg),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                SoteriaFadeIn(
                                  duration: SoteriaAnimations.medium,
                                  child: Semantics(
                                    header: true,
                                    label: 'Pro Mode Lobby',
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CompetitiveBadge(),
                                        SizedBox(height: SoteriaSpacing.sm),
                                        Text(
                                          'PRO CHALLENGE',
                                          style: context.displayMedium.copyWith(
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: -1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: SoteriaSpacing.xl),
                                const ProEntryFeeWidget(),
                                SizedBox(height: SoteriaSpacing.xxl),
                                const DifficultySelectorSection(),
                                SizedBox(height: SoteriaSpacing.xl),
                                const QuestionCountSelectorSection(),
                                SizedBox(height: SoteriaSpacing.xxl),
                                const ProRewardCard(),
                                SizedBox(height: SoteriaSpacing.lg),
                                const ProRiskCard(),
                                SizedBox(height: SoteriaSpacing.xxl * 2),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StartAction(
                      enabled:
                          !state.hasInsufficientCoins &&
                          state.validationError == null,
                      error: state.validationError,
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Pro Session Started: ${session.sessionId}',
                                    ),
                                  ),
                                );
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
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
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
                          style: context.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.monetization_on_rounded,
                              color: SoteriaColors.gold,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${player.coins}',
                              style: context.labelSmall.copyWith(
                                color: SoteriaColors.gold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: SoteriaSpacing.md),
                    SoteriaAvatar(
                      url: player.photoUrl,
                      size: 40,
                      isOnline: true,
                    ),
                  ],
                ),
            ],
          ),
          if (player != null) ...[
            SizedBox(height: SoteriaSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _HeaderStat(label: 'RANK', value: player.role.toUpperCase()),
                _HeaderStat(
                  label: 'WIN RATE',
                  value: '${(player.accuracy * 100).toInt()}%',
                ),
                _HeaderStat(label: 'STREAK', value: '${player.currentStreak}'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  final String label;
  final String value;
  const _HeaderStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w900,
            color: SoteriaColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 9,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _StartAction extends StatelessWidget {
  const _StartAction({
    required this.enabled,
    this.error,
    required this.onStart,
  });
  final bool enabled;
  final String? error;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: SoteriaColors.surface.withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                error!,
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SoteriaButton.primary(
            label: 'INITIALIZE SESSION',
            onPressed: enabled ? onStart : null,
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

    return Semantics(
      label: 'Difficulty selection',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DIFFICULTY',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: SoteriaSpacing.md),
          Row(
            children: ProDifficulty.values.map((d) {
              final isSelected = d == current;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xs),
                  child: GestureDetector(
                    onTap: () =>
                        ref.read(proLobbyProvider.notifier).updateDifficulty(d),
                    child: AnimatedContainer(
                      duration: SoteriaAnimations.fast,
                      padding: EdgeInsets.symmetric(
                        vertical: SoteriaSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? SoteriaColors.primary
                            : SoteriaColors.surface,
                        borderRadius: BorderRadius.circular(SoteriaRadius.md),
                        border: Border.all(
                          color: isSelected
                              ? SoteriaColors.primary
                              : Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          d.label,
                          style: context.labelSmall.copyWith(
                            color: isSelected
                                ? Colors.black
                                : SoteriaColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
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

    return Semantics(
      label: 'Question count selection',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUESTIONS',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: SoteriaSpacing.md),
          Row(
            children: counts.map((c) {
              final isSelected = c == current;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xs),
                  child: GestureDetector(
                    onTap: () => ref
                        .read(proLobbyProvider.notifier)
                        .updateQuestionCount(c),
                    child: AnimatedContainer(
                      duration: SoteriaAnimations.fast,
                      padding: EdgeInsets.symmetric(
                        vertical: SoteriaSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? SoteriaColors.primary
                            : SoteriaColors.surface,
                        borderRadius: BorderRadius.circular(SoteriaRadius.md),
                        border: Border.all(
                          color: isSelected
                              ? SoteriaColors.primary
                              : Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          c.toString(),
                          style: context.labelSmall.copyWith(
                            color: isSelected
                                ? Colors.black
                                : SoteriaColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
