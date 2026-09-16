import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/navigation/app_router.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'streak_celebration_dialog.dart';

class StreakCelebrationListener extends ConsumerWidget {
  final Widget child;

  const StreakCelebrationListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<PlayerProfile?>(currentPlayerProvider, (previous, next) {
      if (next == null) return;

      // Logic: If current streak is a multiple of 7 and we haven't celebrated this milestone yet
      if (next.currentStreak >= 7 && 
          next.currentStreak % 7 == 0 && 
          next.lastStreakMilestoneCelebrated < next.currentStreak) {
        
        _showCelebration(ref, next.currentStreak);
      }
    });

    return child;
  }

  void _showCelebration(WidgetRef ref, int streak) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StreakCelebrationDialog(
        streakDays: streak,
        coinReward: 500,
        onDismiss: () async {
          final player = ref.read(currentPlayerProvider);
          if (player == null) return;

          // Reset streak to start the next 7-day cycle and clear milestone
          await ref.read(playerRepositoryProvider).patchPlayerProfile(
            player.uid,
            {
              'lastStreakMilestoneCelebrated': 0,
              'currentStreak': 0,
            },
          );
          
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
