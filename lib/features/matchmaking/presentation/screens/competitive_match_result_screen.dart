import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/widgets/feedback/soteria_loader.dart';
import '../../../../shared/widgets/soteria_result_components.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../providers/match_result_providers.dart';
import '../../domain/models/competitive_match_result.dart';

class CompetitiveMatchResultScreen extends ConsumerWidget {
  final String matchId;

  const CompetitiveMatchResultScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(currentMatchResultProvider(matchId));

    return SoteriaPage(
      useSafeArea: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: resultAsync.when(
          data: (result) {
            if (result == null) {
              return const Center(child: SoteriaLoader());
            }

            final accuracy = result.playerPerformance.accuracy ?? 0.0;
            final isSuccess = accuracy >= 0.7;
            final xp = result.rewards['xp'] ?? 0;
            final coins = result.rewards['coins'] ?? 0;

            if (isSuccess) {
              return SuccessResultView(
                accuracy: accuracy,
                correctAnswers: result.playerPerformance.correctAnswers,
                xpEarned: xp,
                coinsEarned: coins,
                title: result.outcome == MatchOutcome.victory ? 'VICTORY' : 'MATCH COMPLETE',
                actions: _buildActions(context, ref, matchId),
              );
            }

            return FailureResultView(
              modeName: result.outcome == MatchOutcome.defeat ? 'DEFEAT' : 'MATCH FAILED',
              rating: _calculateRating(accuracy),
              score: result.playerScore,
              accuracy: accuracy,
              xpEarned: xp,
              coinsEarned: coins,
              onExit: () => context.go('/app/versus'),
              detailedMetrics: [
                ResultDetailedMetric(
                  label: 'Correct Answers',
                  value: '${result.playerPerformance.correctAnswers}',
                  icon: Icons.check_circle_rounded,
                  color: SoteriaColors.success,
                ),
                ResultDetailedMetric(
                  label: 'Opponent Score',
                  value: '${result.opponentScore}',
                  icon: Icons.person_outline_rounded,
                  color: SoteriaColors.error,
                ),
                ResultDetailedMetric(
                  label: 'Max Streak',
                  value: '${result.playerPerformance.maxStreak}',
                  icon: Icons.local_fire_department_rounded,
                  color: SoteriaColors.gold,
                ),
              ],
              actions: _buildActions(context, ref, matchId),
            );
          },
          loading: () => const Center(child: SoteriaLoader()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  String _calculateRating(double accuracy) {
    if (accuracy >= 0.9) return 'A';
    if (accuracy >= 0.8) return 'B';
    if (accuracy >= 0.7) return 'C';
    if (accuracy >= 0.6) return 'D';
    return 'F';
  }

  List<Widget> _buildActions(BuildContext context, WidgetRef ref, String matchId) {
    return [
      SoteriaButton.primary(
        label: 'REMATCH',
        onPressed: () => ref.read(rematchControllerProvider.notifier).requestRematch(matchId),
        size: SoteriaButtonSize.lg,
        icon: Icons.refresh_rounded,
      ),
      SizedBox(height: SoteriaSpacing.md),
      SoteriaButton.secondary(
        label: 'VIEW REPLAY',
        onPressed: () => context.push('/app/versus/replay/$matchId'),
        size: SoteriaButtonSize.lg,
      ),
      SizedBox(height: SoteriaSpacing.md),
      SoteriaButton.ghost(
        label: 'RETURN TO LOBBY',
        onPressed: () => context.go('/app/versus'),
        size: SoteriaButtonSize.lg,
      ),
    ];
  }
}

