import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/gameplay_engine/progression/widgets/score_widget.dart';
import 'package:soteria/features/gameplay_engine/progression/widgets/xp_progress_widget.dart';
import 'package:soteria/features/gameplay_engine/progression/widgets/level_badge.dart';
import 'package:soteria/features/gameplay_engine/progression/widgets/streak_indicator.dart';
import 'package:soteria/features/gameplay_engine/progression/widgets/level_up_banner.dart';
import 'package:soteria/features/gameplay_engine/progression/providers/progression_providers.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progress_snapshot.dart';
import 'package:soteria/features/gameplay_engine/progression/services/progression_engine.dart';

class ProgressionPreviewPage extends StatelessWidget {
  const ProgressionPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Score Widgets', [
            _MockedProgression(
              snapshot: ProgressSnapshot(
                score: 1250,
                totalXP: 500,
                level: 5,
                currentStreak: 0,
                maxStreak: 10,
                sessionScore: 1250,
                sessionStreak: 0,
                timestamp: DateTime.now(),
              ),
              child: const ScoreWidget(),
            ),
          ]),
          _buildSection('Streak Indicators', [
            _MockedProgression(
              snapshot: ProgressSnapshot(
                score: 0,
                totalXP: 0,
                level: 1,
                currentStreak: 0,
                maxStreak: 0,
                sessionScore: 0,
                sessionStreak: 0,
                timestamp: DateTime.now(),
              ),
              child: const StreakIndicator(),
            ),
            const SizedBox(width: 16),
            _MockedProgression(
              snapshot: ProgressSnapshot(
                score: 0,
                totalXP: 0,
                level: 1,
                currentStreak: 7,
                maxStreak: 10,
                sessionScore: 0,
                sessionStreak: 7,
                timestamp: DateTime.now(),
              ),
              child: const StreakIndicator(),
            ),
          ], isRow: true),
          _buildSection('Level Badges', [
            _MockedProgression(
              snapshot: ProgressSnapshot(
                score: 0,
                totalXP: 0,
                level: 1,
                currentStreak: 0,
                maxStreak: 0,
                sessionScore: 0,
                sessionStreak: 0,
                timestamp: DateTime.now(),
              ),
              child: const LevelBadge(size: 40),
            ),
            const SizedBox(width: 16),
            _MockedProgression(
              snapshot: ProgressSnapshot(
                score: 0,
                totalXP: 0,
                level: 42,
                currentStreak: 0,
                maxStreak: 0,
                sessionScore: 0,
                sessionStreak: 0,
                timestamp: DateTime.now(),
              ),
              child: const LevelBadge(size: 60),
            ),
          ], isRow: true),
          _buildSection('XP Progress', [
            _MockedProgression(
              snapshot: ProgressSnapshot(
                score: 0,
                totalXP: 250,
                level: 2,
                currentStreak: 0,
                maxStreak: 0,
                sessionScore: 0,
                sessionStreak: 0,
                timestamp: DateTime.now(),
              ),
              child: const XPProgressWidget(),
            ),
          ]),
          _buildSection('Level Up Banner (Overlay)', [
            LevelUpBanner(newLevel: 10, onDismiss: () {}),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<Widget> children, {
    bool isRow = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: SoteriaTypography.headline.copyWith(
            color: SoteriaColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        if (isRow) Row(children: children) else ...children,
        const SizedBox(height: 32),
        const Divider(color: Colors.white10),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _MockedProgression extends StatelessWidget {
  final ProgressSnapshot snapshot;
  final Widget child;

  const _MockedProgression({required this.snapshot, required this.child});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        progressionProvider.overrideWith(
          (ref) => ProgressionNotifierMock(snapshot),
        ),
      ],
      child: child,
    );
  }
}

class ProgressionNotifierMock extends ProgressionNotifier {
  ProgressionNotifierMock(ProgressSnapshot snapshot)
    : super(engine: ProgressionEngine()) {
    state = snapshot;
  }
}
