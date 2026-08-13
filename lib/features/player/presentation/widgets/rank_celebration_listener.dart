import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/rank_providers.dart';
import '../../domain/models/rank_change.dart';
import '../screens/rank_promotion_screen.dart';
import '../screens/rank_demotion_screen.dart';

class RankCelebrationListener extends ConsumerWidget {
  final Widget child;

  const RankCelebrationListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for unacknowledged rank changes
    ref.listen<AsyncValue<List<RankChange>>>(unacknowledgedRankChangesProvider, (
      previous,
      next,
    ) {
      final changes = next.value;
      if (changes != null && changes.isNotEmpty) {
        // Show the most recent unacknowledged change
        final change = changes.first;
        _showCelebration(context, ref, change);
      }
    });

    return child;
  }

  void _showCelebration(BuildContext context, WidgetRef ref, RankChange change) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      pageBuilder: (context, animation, secondaryAnimation) {
        if (change.type == RankChangeType.promotion ||
            change.type == RankChangeType.divisionPromotion) {
          return RankPromotionScreen(
            rankChange: change,
            onContinue: () {
              ref.read(acknowledgeRankChangeActionProvider)(change.changeId);
              Navigator.of(context).pop();
            },
          );
        } else if (change.type == RankChangeType.demotion ||
            change.type == RankChangeType.divisionDemotion) {
          return RankDemotionScreen(
            rankChange: change,
            onContinue: () {
              ref.read(acknowledgeRankChangeActionProvider)(change.changeId);
              Navigator.of(context).pop();
            },
          );
        }
        // For other types, just acknowledge it
        ref.read(acknowledgeRankChangeActionProvider)(change.changeId);
        return const SizedBox.shrink();
      },
    );
  }
}
