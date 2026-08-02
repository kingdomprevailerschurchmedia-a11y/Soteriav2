import 'package:flutter/material.dart';
import 'package:soteria/features/gameplay_engine/progression/widgets/score_widget.dart';
import 'package:soteria/features/gameplay_engine/progression/widgets/streak_indicator.dart';
import 'package:soteria/features/gameplay_engine/progression/widgets/level_badge.dart';

class GameScoreBoard extends StatelessWidget {
  const GameScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LevelBadge(size: 44),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ScoreWidget(useSessionScore: true),
          ),
        ),
        const StreakIndicator(),
      ],
    );
  }
}
