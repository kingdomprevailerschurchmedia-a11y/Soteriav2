import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/design_system/components/soteria_back_button.dart';
import 'package:soteria/core/design_system/components/soteria_state_views.dart';
import '../providers/tournament_leaderboard_provider.dart';
import '../widgets/leaderboard_card.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';

class TournamentLeaderboardScreen extends ConsumerWidget {
  final String tournamentId;

  const TournamentLeaderboardScreen({super.key, required this.tournamentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardAsync = ref.watch(
      tournamentLeaderboardProvider(tournamentId),
    );
    final currentUser = ref.watch(firebaseAuthProvider).currentUser;

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('Final Leaderboard'),
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Center(child: SoteriaBackButton()),
        ),
      ),
      body: leaderboardAsync.when(
        data: (rankings) {
          if (rankings.isEmpty) {
            return const SoteriaEmptyView(
              title: 'NO DATA',
              message: 'Results are still being synchronized.',
              icon: Icons.leaderboard_outlined,
            );
          }
          return Column(
            children: [
              _LeaderboardHeader(),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(SoteriaSpacing.lg),
                  itemCount: rankings.length,
                  cacheExtent: 1000, // Optimize scrolling
                  separatorBuilder: (_, __) =>
                      SizedBox(height: SoteriaSpacing.md),
                  itemBuilder: (context, index) {
                    final r = rankings[index];
                    return RepaintBoundary(
                      child: LeaderboardCard(
                        ranking: r,
                        isCurrentUser: r.uid == currentUser?.uid,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const SoteriaLoadingView(),
        error: (err, stack) => SoteriaEmptyView(
          title: 'SYNC ERROR',
          message: 'Unable to retrieve leaderboard: $err',
          icon: Icons.sync_problem_rounded,
          actionLabel: 'RETRY',
          onAction: () =>
              ref.invalidate(tournamentLeaderboardProvider(tournamentId)),
        ),
      ),
    );
  }
}

class _LeaderboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.xl,
        vertical: SoteriaSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'RANK / PLAYER',
              style: context.labelSmall.copyWith(color: SoteriaColors.muted),
            ),
          ),
          Text(
            'SCORE / ACC',
            style: context.labelSmall.copyWith(color: SoteriaColors.muted),
          ),
        ],
      ),
    );
  }
}
