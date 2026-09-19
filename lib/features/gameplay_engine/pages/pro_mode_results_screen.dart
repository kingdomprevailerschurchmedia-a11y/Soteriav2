import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/widgets/feedback/soteria_error_widget.dart';
import '../../../../core/widgets/feedback/soteria_loader.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/navigation/soteria_routes.dart';
import '../models/game_state.dart';
import '../models/pro_mode_result.dart';
import '../providers/pro_mode_results_provider.dart';

import '../../../../shared/widgets/soteria_result_components.dart';
import '../../../../shared/widgets/soteria_page.dart';

class ProModeResultsScreen extends ConsumerStatefulWidget {
  final GameState? gameState;
  final String? sessionId;

  const ProModeResultsScreen({
    super.key,
    this.gameState,
    this.sessionId,
  });

  @override
  ConsumerState<ProModeResultsScreen> createState() => _ProModeResultsScreenState();
}

class _ProModeResultsScreenState extends ConsumerState<ProModeResultsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.gameState != null) {
        ref.read(proModeResultsProvider.notifier).completeSession(widget.gameState!);
      } else if (widget.sessionId != null) {
        ref.read(proModeResultsProvider.notifier).loadResult(widget.sessionId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(proModeResultsProvider);

    return SoteriaPage(
      showBackground: false,
      useSafeArea: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: state.result.when(
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SoteriaLoader(),
                SizedBox(height: 24),
                Text(
                  'VERIFYING PERFORMANCE...',
                  style: TextStyle(
                    color: SoteriaColors.gold,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          error: (err, st) => Center(
            child: SoteriaErrorWidget(
              message: kDebugMode 
                  ? 'AUTHORITATIVE VALIDATION FAILED\n$err' 
                  : 'AUTHORITATIVE VALIDATION FAILED',
              onRetry: () {
                if (widget.gameState != null) {
                  ref
                      .read(proModeResultsProvider.notifier)
                      .completeSession(widget.gameState!);
                } else if (widget.sessionId != null) {
                  ref
                      .read(proModeResultsProvider.notifier)
                      .loadResult(widget.sessionId!);
                }
              },
            ),
          ),
          data: (result) => _buildContent(context, result),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProModeResult result) {
    final isSuccess = result.accuracy >= 0.7;

    if (isSuccess) {
      return SuccessResultView(
        accuracy: result.accuracy,
        correctAnswers: result.correctAnswers,
        xpEarned: result.totalXP,
        coinsEarned: result.rewards.totalCoins,
        title: 'PRO MODE COMPLETE',
        actions: _buildActionWidgets(context, result),
      );
    }

    return FailureResultView(
      modeName: 'PRO MATCH FAILED',
      rating: result.rating,
      score: result.finalScore,
      accuracy: result.accuracy,
      xpEarned: result.totalXP,
      coinsEarned: result.rewards.totalCoins,
      onExit: () => context.go(SoteriaRoutes.proMode),
      detailedMetrics: [
        ResultDetailedMetric(
          label: 'Correct Answers',
          value: '${result.correctAnswers}',
          icon: Icons.check_circle_rounded,
          color: SoteriaColors.success,
        ),
        ResultDetailedMetric(
          label: 'Wrong Answers',
          value: '${result.wrongAnswers}',
          icon: Icons.cancel_rounded,
          color: SoteriaColors.error,
        ),
        ResultDetailedMetric(
          label: 'Total Time',
          value: _formatDuration(result.totalDuration),
          icon: Icons.schedule_rounded,
          color: Colors.white70,
        ),
        ResultDetailedMetric(
          label: 'Avg Response',
          value: '${(result.avgResponseTime.inMilliseconds / 1000).toStringAsFixed(2)}s',
          icon: Icons.speed_rounded,
          color: Colors.white70,
        ),
      ],
      actions: _buildActionWidgets(context, result),
    );
  }

  List<Widget> _buildActionWidgets(BuildContext context, ProModeResult result) {
    return [
      SoteriaButton.primary(
        label: 'PLAY AGAIN',
        onPressed: () => context.go(SoteriaRoutes.proMode),
        size: SoteriaButtonSize.lg,
        icon: Icons.refresh_rounded,
      ),
      SizedBox(height: SoteriaSpacing.md),
      SoteriaButton.secondary(
        label: 'REVIEW ANSWERS',
        onPressed: () {
          context.push(
            SoteriaRoutes.proReview.replaceFirst(':id', result.sessionId),
          );
        },
        size: SoteriaButtonSize.lg,
        icon: Icons.fact_check_rounded,
      ),
      SizedBox(height: SoteriaSpacing.md),
      SoteriaButton.ghost(
        label: 'RETURN TO LOBBY',
        onPressed: () => context.go(SoteriaRoutes.proMode),
        size: SoteriaButtonSize.lg,
      ),
    ];
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }
}

