import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../gameplay_engine/models/versus_match.dart';
import '../providers/match_lifecycle_providers.dart';
import 'match_ready_view.dart';
import 'match_countdown_view.dart';
import 'competitive_match_result_screen.dart';
import '../../../quiz/presentation/screens/quiz_gameplay_screen.dart';
import '../../../../shared/widgets/soteria_page.dart';

class VersusMatchOrchestrator extends ConsumerStatefulWidget {
  final String matchId;
  const VersusMatchOrchestrator({super.key, required this.matchId});

  @override
  ConsumerState<VersusMatchOrchestrator> createState() => _VersusMatchOrchestratorState();
}

class _VersusMatchOrchestratorState extends ConsumerState<VersusMatchOrchestrator> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(activeMatchIdProvider.notifier).state = widget.matchId;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(activeMatchIdProvider.notifier).state = null;
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matchAsync = ref.watch(activeMatchProvider);

    return SoteriaPage(
      child: matchAsync.when(
        data: (match) {
          if (match == null) return const Center(child: Text('Match not found'));

          switch (match.status) {
            case MatchStatus.created:
            case MatchStatus.waiting:
            case MatchStatus.ready:
              return MatchReadyView(match: match);
            case MatchStatus.countdown:
              return MatchCountdownView(match: match);
            case MatchStatus.active:
              // Start syncing progress
              ref.watch(versusProgressSyncProvider);
              return const QuizGameplayScreen();
            case MatchStatus.finishing:
            case MatchStatus.processing:
            case MatchStatus.completed:
              return CompetitiveMatchResultScreen(matchId: widget.matchId);
            case MatchStatus.abandoned:
            case MatchStatus.cancelled:
            case MatchStatus.failed:
            case MatchStatus.expired:
              return _MatchEndFallback(status: match.status);
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _MatchEndFallback extends StatelessWidget {
  final MatchStatus status;
  const _MatchEndFallback({required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Match Ended: ${status.name.toUpperCase()}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/app/versus'),
              child: const Text('RETURN TO LOBBY'),
            ),
          ],
        ),
      ),
    );
  }
}
