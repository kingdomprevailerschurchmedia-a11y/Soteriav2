import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';
import 'package:soteria/shared/widgets/soteria_page.dart';
import 'package:soteria/features/dashboard/presentation/providers/practice_lobby_providers.dart';
import 'package:soteria/features/dashboard/presentation/widgets/lobby/category_selector.dart';
import 'package:soteria/features/dashboard/presentation/widgets/lobby/config_selectors.dart';
import 'package:soteria/features/dashboard/presentation/widgets/lobby/session_summary_card.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/features/gameplay_engine/models/practice_session_config.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
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
                        padding: EdgeInsets.all(SoteriaSpacing.lg),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            SoteriaFadeIn(
                              duration: SoteriaAnimations.medium,
                              child: Text(
                                'READY TO TRAIN?',
                                style: context.displayMedium.copyWith(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -1,
                                ),
                              ),
                            ),
                            SizedBox(height: SoteriaSpacing.xl),
                            _buildInterestsToggle(ref, state.config),
                            SizedBox(height: SoteriaSpacing.xl),
                            if (!state.config.useInterests) ...[
                              const CategorySelector(),
                              SizedBox(height: SoteriaSpacing.xxl),
                            ],
                            const DifficultySelector(),
                            SizedBox(height: SoteriaSpacing.xl),
                            const QuestionCountSelector(),
                            SizedBox(height: SoteriaSpacing.xxl),
                            if (state.estimatedRewards != null)
                              SessionSummaryCard(
                                rewards: state.estimatedRewards!,
                              ),
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
  Widget _buildInterestsToggle(WidgetRef ref, PracticeSessionConfig config) {
    return SoteriaCard(
      onTap: () => ref.read(practiceLobbyProvider.notifier).setUseInterests(!config.useInterests),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded, color: SoteriaColors.gold),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Use My Interests',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Personalized mix based on your profile',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
                ),
              ],
            ),
          ),
          Switch(
            value: config.useInterests,
            onChanged: (val) => ref.read(practiceLobbyProvider.notifier).setUseInterests(val),
            activeColor: SoteriaColors.gold,
          ),
        ],
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
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onPressed: () => context.pop(),
          ),
          IconButton(
            icon: const Icon(
              Icons.history_rounded,
              color: Colors.white70,
            ),
            onPressed: () => context.push(SoteriaRoutes.practiceHistory),
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
                    Text(
                      'Lvl ${player.level}',
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.gold,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: SoteriaSpacing.md),
                SoteriaAvatar(
                  imageUrl: player.photoUrl,
                  size: 40,
                  isOnline: true,
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
      padding: EdgeInsets.fromLTRB(
        SoteriaSpacing.lg,
        SoteriaSpacing.lg,
        SoteriaSpacing.lg,
        SoteriaSpacing.lg + 80.h,
      ),
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
