import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/design_system/components/soteria_state_views.dart';
import '../providers/tournament_details_provider.dart';
import 'package:soteria/features/tournaments/presentation/providers/tournament_gameplay_provider.dart';
import 'package:soteria/features/tournaments/presentation/widgets/tournament_countdown_widget.dart';

class TournamentLobbyScreen extends ConsumerWidget {
  final String tournamentId;

  const TournamentLobbyScreen({super.key, required this.tournamentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentAsync = ref.watch(tournamentDetailsProvider(tournamentId));

    // Listen for gameplay start
    ref.listen(tournamentGameplayProvider(tournamentId), (prev, next) {
      if (next == TournamentGameplayState.playing ||
          next == TournamentGameplayState.starting) {
        context.go(
          SoteriaRoutes.tournamentGameplay.replaceAll(':id', tournamentId),
        );
      }
    });

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('Tournament Lobby'),
        backgroundColor: Colors.transparent,
        leading: const BackButton(),
      ),
      body: tournamentAsync.when(
        data: (tournament) {
          if (tournament == null) {
            return const SoteriaEmptyView(
              title: 'LOBBY CLOSED',
              message: 'This tournament session is no longer available.',
              icon: Icons.door_back_door_rounded,
            );
          }
          return Column(
            children: [
              SizedBox(height: SoteriaSpacing.xxl),
              TournamentCountdownWidget(
                targetDate: tournament.startTime,
                label: 'Match Starts In',
              ),
              SizedBox(height: SoteriaSpacing.xxl),
              Expanded(
                child: _PlayersList(
                  registeredCount: tournament.registeredPlayers,
                  maxCount: tournament.maxPlayers,
                ),
              ),
            ],
          );
        },
        loading: () => const SoteriaLoadingView(),
        error: (err, stack) => SoteriaEmptyView(
          title: 'CONNECTION ERROR',
          message: 'Unable to sync with lobby. Checking connection...',
          icon: Icons.cloud_off_rounded,
          actionLabel: 'RETRY',
          onAction: () =>
              ref.invalidate(tournamentDetailsProvider(tournamentId)),
        ),
      ),
    );
  }
}

class _PlayersList extends StatelessWidget {
  final int registeredCount;
  final int maxCount;

  const _PlayersList({required this.registeredCount, required this.maxCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'REGISTERED PLAYERS',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
              Text(
                '$registeredCount / $maxCount',
                style: context.labelSmall.copyWith(color: SoteriaColors.gold),
              ),
            ],
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            itemCount: registeredCount,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                backgroundColor: SoteriaColors.primary.withValues(alpha: 0.2),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: SoteriaColors.primary),
                ),
              ),
              title: Text('Player ${index + 1}', style: context.bodyMedium),
              trailing: const Icon(
                Icons.check_circle,
                color: SoteriaColors.success,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
