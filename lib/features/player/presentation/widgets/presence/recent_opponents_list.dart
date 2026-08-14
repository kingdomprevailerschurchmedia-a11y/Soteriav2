import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/player/presentation/providers/match_history_providers.dart';
import 'recent_opponent_card.dart';

class RecentOpponentsList extends ConsumerWidget {
  const RecentOpponentsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentOpponentsAsync = ref.watch(recentOpponentsProvider);

    return recentOpponentsAsync.when(
      data: (opponentIds) {
        if (opponentIds.isEmpty) {
          return const Center(child: Text('No recent opponents.'));
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: opponentIds.length,
          separatorBuilder: (context, index) => SizedBox(height: SoteriaSpacing.md),
          itemBuilder: (context, index) => RecentOpponentCard(userId: opponentIds[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
    );
  }
}
