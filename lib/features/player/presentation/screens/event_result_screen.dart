import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import '../../../../shared/widgets/soteria_result_components.dart';
import '../../../../shared/widgets/soteria_page.dart';

class EventResultScreen extends ConsumerWidget {
  final String eventId;
  final int score;

  const EventResultScreen({
    super.key,
    required this.eventId,
    required this.score,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock accuracy for events as it's score-based
    final accuracy = (score / 1000).clamp(0.0, 1.0);
    final isSuccess = accuracy >= 0.7;

    return SoteriaPage(
      useSafeArea: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: isSuccess
            ? SuccessResultView(
                accuracy: accuracy,
                correctAnswers: score ~/ 10,
                xpEarned: score ~/ 2,
                coinsEarned: score ~/ 5,
                title: 'EVENT COMPLETE',
                actions: _buildActions(context, eventId),
              )
            : FailureResultView(
                modeName: 'EVENT FAILED',
                rating: _calculateRating(accuracy),
                score: score,
                accuracy: accuracy,
                xpEarned: score ~/ 4,
                coinsEarned: score ~/ 10,
                onExit: () => context.go('/app/events'),
                detailedMetrics: [
                  ResultDetailedMetric(
                    label: 'Final Score',
                    value: score.toString(),
                    icon: Icons.emoji_events_rounded,
                    color: SoteriaColors.gold,
                  ),
                ],
                actions: _buildActions(context, eventId),
              ),
      ),
    );
  }

  String _calculateRating(double accuracy) {
    if (accuracy >= 0.9) return 'A';
    if (accuracy >= 0.8) return 'B';
    if (accuracy >= 0.7) return 'C';
    if (accuracy >= 0.6) return 'D';
    return 'F';
  }

  List<Widget> _buildActions(BuildContext context, String eventId) {
    return [
      SoteriaButton.primary(
        label: 'VIEW LEADERBOARD',
        onPressed: () => context.push('/app/events/leaderboard/$eventId'),
        size: SoteriaButtonSize.lg,
        icon: Icons.leaderboard_rounded,
      ),
      SizedBox(height: SoteriaSpacing.md),
      SoteriaButton.secondary(
        label: 'RETURN TO EVENTS',
        onPressed: () => context.go('/app/events'),
        size: SoteriaButtonSize.lg,
      ),
    ];
  }
}

