import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/screens/achievement_list_screen.dart';
import '../presentation/providers/achievement_providers.dart';
import '../domain/models/achievement.dart';

class AchievementPreviews extends StatelessWidget {
  const AchievementPreviews({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        playerAchievementMapProvider.overrideWithValue({
          'first_game': PlayerAchievement(
            userId: 'u1',
            achievementId: 'first_game',
            status: AchievementStatus.unlocked,
            currentValue: 1.0,
            targetValue: 1.0,
            unlockedAt: DateTime.now().subtract(const Duration(days: 1)),
          ),
          'score_1k': PlayerAchievement(
            userId: 'u1',
            achievementId: 'score_1k',
            status: AchievementStatus.unlocked,
            currentValue: 1000.0,
            targetValue: 1000.0,
            unlockedAt: DateTime.now(),
          ),
          'level_10': PlayerAchievement(
            userId: 'u1',
            achievementId: 'level_10',
            status: AchievementStatus.inProgress,
            currentValue: 5.0,
            targetValue: 10.0,
          ),
        }),
      ],
      child: const AchievementListScreen(),
    );
  }
}
