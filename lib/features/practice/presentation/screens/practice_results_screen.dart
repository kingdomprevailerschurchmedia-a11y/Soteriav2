import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/widgets/feedback/soteria_loader.dart';
import '../../../gameplay_engine/models/game_state.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../providers/practice_providers.dart';
import '../states/practice_result_state.dart';
import '../../domain/models/practice_result.dart';
import '../../../../core/navigation/soteria_routes.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../shared/widgets/soteria_result_components.dart';
import '../../../../shared/widgets/soteria_page.dart';

class PracticeResultsScreen extends ConsumerStatefulWidget {
  const PracticeResultsScreen({super.key, required this.gameState});

  final GameState gameState;

  @override
  ConsumerState<PracticeResultsScreen> createState() => _PracticeResultsScreenState();
}

class _PracticeResultsScreenState extends ConsumerState<PracticeResultsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(practiceResultProvider.notifier).finalize(widget.gameState);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(practiceResultProvider);

    final isLoading = state.maybeWhen(
      initial: () => true,
      calculating: () => true,
      orElse: () => false,
    );
    final error = state.maybeWhen(
      error: (msg) => msg,
      orElse: () => null,
    );

    return SoteriaPage(
      isLoading: isLoading,
      error: error,
      showBackground: false,
      useSafeArea: false,
      onRetry: () {
        ref.read(practiceResultProvider.notifier).finalize(widget.gameState);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: state.maybeWhen(
          success: (result) => _buildContent(context, result),
          orElse: () => const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PracticeResult result) {
    final isSuccess = result.accuracy >= 0.7;

    if (isSuccess) {
      return SuccessResultView(
        accuracy: result.accuracy,
        correctAnswers: result.correctAnswers,
        xpEarned: result.xpEarned,
        coinsEarned: result.coinsEarned,
        title: 'PRACTICE RESULTS',
        insights: result.insights.map((i) => ResultInsight(
          title: i.title,
          description: i.description,
          isPositive: i.isPositive,
        )).toList(),
        recommendation: result.recommendation != null ? ResultRecommendation(
          title: result.recommendation!.title,
          subtitle: 'Try ${result.recommendation!.difficulty.name.toUpperCase()} for more challenge.',
          onTap: () {
            ref.read(practiceResultProvider.notifier).practiceAgain(result.recommendation!);
            context.go(SoteriaRoutes.practiceSession);
          },
        ) : null,
        categoryPerformance: result.categoryPerformance.values.map((p) => ResultCategoryPerformance(
          label: p.categoryId,
          accuracy: p.accuracy,
          categoryId: p.categoryId,
        )).toList(),
        actions: _buildActions(context, result),
      );
    }

    return FailureResultView(
      modeName: 'PRACTICE FAILED',
      rating: _calculateRating(result.accuracy),
      score: result.correctAnswers * 10, // Mock score if not available
      accuracy: result.accuracy,
      xpEarned: result.xpEarned,
      coinsEarned: result.coinsEarned,
      onExit: () => context.go(SoteriaRoutes.main),
      detailedMetrics: [
        ResultDetailedMetric(
          label: 'Correct Answers',
          value: '${result.correctAnswers}',
          icon: Icons.check_circle_rounded,
          color: SoteriaColors.success,
        ),
        ResultDetailedMetric(
          label: 'Total Questions',
          value: '${result.totalQuestions}',
          icon: Icons.help_outline_rounded,
          color: Colors.white70,
        ),
      ],
      actions: _buildActions(context, result),
    );
  }

  String _calculateRating(double accuracy) {
    if (accuracy >= 0.9) return 'A';
    if (accuracy >= 0.8) return 'B';
    if (accuracy >= 0.7) return 'C';
    if (accuracy >= 0.6) return 'D';
    return 'F';
  }

  List<Widget> _buildActions(BuildContext context, PracticeResult result) {
    return [
      SoteriaButton.primary(
        label: 'PRACTICE AGAIN',
        onPressed: () => context.go(SoteriaRoutes.practice),
        size: SoteriaButtonSize.lg,
        icon: Icons.refresh_rounded,
      ),
      SizedBox(height: SoteriaSpacing.md),
      SoteriaButton.secondary(
        label: 'RETURN HOME',
        onPressed: () => context.go(SoteriaRoutes.main),
        size: SoteriaButtonSize.lg,
      ),
    ];
  }
}

