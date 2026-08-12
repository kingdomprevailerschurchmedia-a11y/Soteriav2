import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_streak.dart';
import '../domain/models/momentum.dart';
import '../presentation/providers/streak_providers.dart';
import '../presentation/widgets/streak/competitive_streak_card.dart';
import '../presentation/widgets/streak/momentum_indicator.dart';

class StreakPreviewWrapper extends StatelessWidget {
  final CompetitiveStreak? streak;
  final CompetitiveMomentum? momentum;

  const StreakPreviewWrapper({super.key, this.streak, this.momentum});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        currentWinStreakProvider.overrideWith((ref) => Stream.value(streak)),
        currentMomentumProvider.overrideWith((ref) => Stream.value(momentum)),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFF0B012A),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (streak != null) CompetitiveStreakCard(streak: streak!),
                const SizedBox(height: 24),
                if (momentum != null) MomentumIndicator(momentum: momentum!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StreakPreviews {
  static CompetitiveStreak mockStreak({int current = 3, int best = 10}) {
    return CompetitiveStreak(
      userId: 'u1',
      type: StreakType.win,
      current: current,
      best: best,
      seasonBest: current,
      startedAt: DateTime.now().subtract(const Duration(days: 2)),
      lastQualifiedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static CompetitiveMomentum mockMomentum({
    MomentumState state = MomentumState.strong,
  }) {
    return CompetitiveMomentum(
      userId: 'u1',
      state: state,
      reason: '3 consecutive wins',
      intensity: 0.7,
      updatedAt: DateTime.now(),
      recentSignals: ['3 Wins', 'A Rating'],
    );
  }

  static Widget win3() => StreakPreviewWrapper(
    streak: mockStreak(current: 3),
    momentum: mockMomentum(state: MomentumState.strong),
  );
  static Widget win10() => StreakPreviewWrapper(
    streak: mockStreak(current: 10, best: 10),
    momentum: mockMomentum(state: MomentumState.peak),
  );
  static Widget cooling() => StreakPreviewWrapper(
    streak: mockStreak(current: 0, best: 12),
    momentum: mockMomentum(state: MomentumState.cooling),
  );
}
