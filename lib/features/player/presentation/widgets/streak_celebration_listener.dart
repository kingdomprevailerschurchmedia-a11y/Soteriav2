import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        
        _showCelebration(context, ref, next.currentStreak);
      }
    });

    return child;
  }

  void _showCelebration(BuildContext context, WidgetRef ref, int streak) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StreakCelebrationDialog(
        streakDays: streak,
        coinReward: 500,
        onDismiss: () {
          // Mark as celebrated in Firestore
          ref.read(playerRepositoryProvider).patchPlayerProfile(
            ref.read(currentPlayerProvider)!.uid,
            {'lastStreakMilestoneCelebrated': streak},
          );
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
