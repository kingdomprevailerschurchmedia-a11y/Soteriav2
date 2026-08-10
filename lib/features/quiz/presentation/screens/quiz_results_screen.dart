import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/navigation/soteria_routes.dart';
import '../providers/quiz_providers.dart';
import '../../domain/models/quiz_result.dart';
import '../widgets/results/results_components.dart';

class QuizResultsScreen extends ConsumerWidget {
  const QuizResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizControllerProvider);
    final result = state.result;

    if (result == null) {
      return const SafeGradientScaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return SafeGradientScaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 40.h)),
          SliverToBoxAdapter(child: ResultsHero(result: result)),
          SliverToBoxAdapter(child: ScoreSummary(result: result)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            sliver: SliverToBoxAdapter(
              child: Text(
                'QUESTION BREAKDOWN',
                style: context.labelMedium.copyWith(
                  color: Colors.white70,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => QuestionResultCard(
                  result: result.questionResults[index],
                ),
                childCount: result.questionResults.length,
              ),
            ),
          ),
          SliverToBoxAdapter(child: _ResultActions()),
          SliverToBoxAdapter(child: SizedBox(height: 40.h)),
        ],
      ),
    );
  }
}

class _ResultActions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              ref.read(quizControllerProvider.notifier).resetQuiz();
              context.go(SoteriaRoutes.main); 
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: SoteriaColors.primary,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 56.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SoteriaRadius.lg),
              ),
            ),
            child: Text(
              'PLAY AGAIN',
              style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: SoteriaSpacing.md),
          TextButton(
            onPressed: () {
              ref.read(quizControllerProvider.notifier).resetQuiz();
              context.go(SoteriaRoutes.main);
            },
            child: Text(
              'RETURN HOME',
              style: context.titleSmall.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
