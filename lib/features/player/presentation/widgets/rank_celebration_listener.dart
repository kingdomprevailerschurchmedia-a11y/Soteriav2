import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/navigation/app_router.dart';
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
        _showCelebration(ref, change);
      }
    });

    return child;
  }

  void _showCelebration(WidgetRef ref, RankChange change) {
    // Only show dialog for major rank changes (Promotions/Demotions/Placement)
    final isMajorChange = change.isTierChange ||
        change.isDivisionChange ||
        change.type == RankChangeType.promotion ||
        change.type == RankChangeType.divisionPromotion ||
        change.type == RankChangeType.demotion ||
        change.type == RankChangeType.divisionDemotion ||
        change.type == RankChangeType.placement;

    if (kDebugMode) {
      print('RANK CELEBRATION: id=${change.changeId}, type=${change.type.name}, major=$isMajorChange');
    }

    if (!isMajorChange || change.newRank.isEmpty) {
      // Just acknowledge minor points changes (increase/decrease) or invalid data in the background
      ref.read(acknowledgeRankChangeActionProvider)(change.changeId);
      return;
    }

    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

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
        
        // Fallback for unexpected cases (should be handled by isMajorChange check above)
        return const SizedBox.shrink();
      },
    );
  }
}
