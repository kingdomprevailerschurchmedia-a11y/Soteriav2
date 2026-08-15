import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import '../../domain/models/tournament_ranking.dart';
import '../providers/tournament_results_provider.dart';
import '../widgets/tournament_prize_card.dart';
import '../../../gameplay_engine/widgets/competitive_statistics_card.dart';
import '../../../gameplay_engine/models/game_mode.dart';
import '../../../gameplay_engine/models/game_result.dart';

class TournamentResultsScreen extends ConsumerWidget {
  final String tournamentId;

  const TournamentResultsScreen({super.key, required this.tournamentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(tournamentResultsProvider(tournamentId));

    if (results.isLoading) {
      return const SafeGradientScaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (results.ranking == null) {
      return SafeGradientScaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Rankings are still being calculated...'),
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

    return SafeGradientScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        child: Column(
          children: [
            SizedBox(height: 64.h),
            _buildCelebration(context, ranking.rank),
            SizedBox(height: SoteriaSpacing.xxl),
            _buildRankSection(context, ranking.rank),
            SizedBox(height: SoteriaSpacing.xl),
            if (ranking.prize != null) ...[
              TournamentPrizeCard(reward: ranking.prize!),
              SizedBox(height: SoteriaSpacing.xl),
            ],
            _buildStatsCard(ranking),
            SizedBox(height: SoteriaSpacing.xxl),
            SoteriaButton.primary(
              label: 'VIEW FULL LEADERBOARD',
              onPressed: () =>
                  context.push('/app/tournaments/leaderboard/$tournamentId'),
              icon: Icons.leaderboard_rounded,
            ),
            SizedBox(height: SoteriaSpacing.md),
            SoteriaButton.ghost(
              label: 'BACK TO MENU',
              onPressed: () => context.go('/app/tournaments'),
            ),
            SizedBox(height: SoteriaSpacing.xxxl),
          ],
        ),
      ),
    );
  }

  Widget _buildCelebration(BuildContext context, int rank) {
    String title = 'TOURNAMENT OVER';
    IconData icon = Icons.emoji_events_rounded;
    Color color = SoteriaColors.primary;

    if (rank == 1) {
      title = 'TOURNAMENT CHAMPION';
      color = SoteriaColors.gold;
    } else if (rank <= 3) {
      title = 'PODIUM FINISH';
      color = const Color(0xFFC0C0C0);
    } else if (rank <= 10) {
      title = 'TOP 10 FINISH';
    }

    return Column(
      children: [
        Icon(icon, color: color, size: 64.w),
        SizedBox(height: SoteriaSpacing.md),
        Text(
          title,
          style: context.displaySmall.copyWith(
            fontWeight: FontWeight.w900,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRankSection(BuildContext context, int rank) {
    return Column(
      children: [
        Text(
          'YOUR FINAL RANK',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '#',
              style: context.displayMedium.copyWith(
                color: SoteriaColors.muted,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              rank.toString(),
              style: context.displayLarge.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCard(TournamentRanking ranking) {
    // Reusing CompetitiveStatisticsCard but needs GameResult
    final mockResult = GameResult(
      sessionId: 'tournament',
      playerId: ranking.uid,
      mode: GameMode.tournament,
      finalScore: ranking.score,
      totalXP: ranking.prize?.xp ?? 0,
      totalQuestions: 20, // Mock
      correctAnswers: ranking.score ~/ 200, // Simplistic mapping
      wrongAnswers: 0,
      totalDuration: ranking.completionTime,
      accuracy: ranking.accuracy,
      maxStreak: 0,
      avgResponseTime: Duration(
        milliseconds: (ranking.completionTime.inMilliseconds / 20).toInt(),
      ),
      timestamp: DateTime.now(),
    );

    return CompetitiveStatisticsCard(result: mockResult);
  }
}
