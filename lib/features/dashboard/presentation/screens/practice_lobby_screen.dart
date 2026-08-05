import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/widgets/buttons/soteria_button.dart';
import '../../../../core/widgets/animations/soteria_animations.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../providers/practice_lobby_providers.dart';
import '../widgets/lobby/category_selector.dart';
import '../widgets/lobby/config_selectors.dart';
import '../widgets/lobby/session_summary_card.dart';
import '../../../player/providers/player_providers.dart';

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
                        padding: EdgeInsets.all(SoteriaSpacing.lg),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            SoteriaFadeIn(
                              duration: const Duration(milliseconds: 400),
                              child: Text(
                                'READY TO TRAIN?',
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2,
                                    ),
                              ),
                            ),
                            SizedBox(height: SoteriaSpacing.xl),
                            const CategorySelector(),
                            SizedBox(height: SoteriaSpacing.xxl),
                            const DifficultySelector(),
                            SizedBox(height: SoteriaSpacing.xl),
                            const QuestionCountSelector(),
                            SizedBox(height: SoteriaSpacing.xxl),
                            if (state.estimatedRewards != null)
                              SessionSummaryCard(rewards: state.estimatedRewards!),
                            SizedBox(height: SoteriaSpacing.xxl * 2),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                _StartAction(
                  enabled: state.validationError == null,
                  error: state.validationError,
                  onStart: () async {
                    final session = await ref.read(practiceLobbyProvider.notifier).startSession();
                    if (session != null && context.mounted) {
                      // Navigate to Game Screen (Coming in 5.2)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Session Initialized: ${session.sessionId}')),
                      );
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
                      style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lvl ${player.level}',
                      style: context.labelSmall.copyWith(color: SoteriaColors.gold),
                    ),
                  ],
                ),
                SizedBox(width: SoteriaSpacing.md),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: player.photoUrl.isNotEmpty ? NetworkImage(player.photoUrl) : null,
                  backgroundColor: Colors.white10,
                  child: player.photoUrl.isEmpty ? const Icon(Icons.person, color: Colors.white38) : null,
                ),
              ],
            ),
        ],
      ),
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
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                error!,
                style: context.labelSmall.copyWith(color: SoteriaColors.error),
              ),
            ),
          SoteriaButton.primary(
            label: 'START PRACTICE',
            onPressed: enabled ? onStart : null,
          ),
        ],
      ),
    );
  }
}
