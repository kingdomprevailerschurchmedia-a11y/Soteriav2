import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import '../../../../shared/widgets/soteria_result_components.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../providers/tournament_results_provider.dart';

class TournamentResultsScreen extends ConsumerWidget {
  final String tournamentId;

  const TournamentResultsScreen({super.key, required this.tournamentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(tournamentResultsProvider(tournamentId));

    if (results.isLoading) {
      return const SoteriaPage(
        showBackground: false,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (results.ranking == null) {
      return SoteriaPage(
        showBackground: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Rankings are still being calculated...', style: context.bodyMedium),
              SizedBox(height: SoteriaSpacing.xl),
              SoteriaButton.primary(
                label: 'REFRESH',
                onPressed: () =>
                    ref.invalidate(tournamentResultsProvider(tournamentId)),
              ),
            ],
          ),
        ),
      );
    }

    final ranking = results.ranking!;
    final isSuccess = ranking.accuracy >= 0.7;

    return SoteriaPage(
      useSafeArea: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: isSuccess
            ? SuccessResultView(
                accuracy: ranking.accuracy,
                correctAnswers: ranking.score ~/ 100, // Approximate mapping
                xpEarned: ranking.prize?.xp ?? 0,
                coinsEarned: ranking.prize?.coins ?? 0,
                title: ranking.rank == 1 ? 'TOURNAMENT CHAMPION' : 'TOURNAMENT COMPLETE',
                actions: _buildActions(context, tournamentId),
              )
            : FailureResultView(
                modeName: 'TOURNAMENT FAILED',
                rating: _calculateRating(ranking.accuracy),
                score: ranking.score,
                accuracy: ranking.accuracy,
                xpEarned: ranking.prize?.xp ?? 0,
                coinsEarned: ranking.prize?.coins ?? 0,
                onExit: () => context.go('/app/tournaments'),
                detailedMetrics: [
                  ResultDetailedMetric(
                    label: 'Final Rank',
                    value: '#${ranking.rank}',
                    icon: Icons.emoji_events_rounded,
                    color: SoteriaColors.gold,
                  ),
                  ResultDetailedMetric(
                    label: 'Score',
                    value: '${ranking.score}',
                    icon: Icons.star_rounded,
                    color: SoteriaColors.primary,
                  ),
                ],
                actions: _buildActions(context, tournamentId),
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

  List<Widget> _buildActions(BuildContext context, String tournamentId) {
    return [
      SoteriaButton.primary(
        label: 'VIEW FULL LEADERBOARD',
        onPressed: () => context.push('/app/tournaments/leaderboard/$tournamentId'),
        size: SoteriaButtonSize.lg,
        icon: Icons.leaderboard_rounded,
      ),
      SizedBox(height: SoteriaSpacing.md),
      SoteriaButton.secondary(
        label: 'BACK TO MENU',
        onPressed: () => context.go('/app/tournaments'),
        size: SoteriaButtonSize.lg,
      ),
    ];
  }
}
