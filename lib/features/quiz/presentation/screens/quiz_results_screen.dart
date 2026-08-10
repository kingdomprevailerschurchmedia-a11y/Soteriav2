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
import '../../domain/models/question_result.dart';

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
          SliverToBoxAdapter(child: _ResultsHero(result: result)),
          SliverToBoxAdapter(child: _PerformanceSummary(result: result)),
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
                (context, index) => _QuestionResultCard(
                  result: result.questionResults[index],
                ),
                childCount: result.questionResults.length,
              ),
            ),
          ),
          SliverToBoxAdapter(child: _ResultActions(result: result)),
          SliverToBoxAdapter(child: SizedBox(height: 40.h)),
        ],
      ),
    );
  }
}

class _ResultsHero extends StatelessWidget {
  const _ResultsHero({required this.result});
  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'QUIZ COMPLETE',
          style: context.labelLarge.copyWith(
            color: SoteriaColors.secondary,
            letterSpacing: 4.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: result.finalScore),
          duration: const Duration(seconds: 2),
          curve: Curves.easeOutCubic,
          builder: (context, value, _) {
            return Text(
              value.toString(),
              style: context.displayLarge.copyWith(
                fontSize: 72.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.0,
              ),
            );
          },
        ),
        Text(
          'POINTS',
          style: context.titleMedium.copyWith(
            color: Colors.white54,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        _XpBadge(xp: result.xpEarned),
        SizedBox(height: SoteriaSpacing.lg),
        Text(
          result.performanceRating.toUpperCase(),
          style: context.headlineSmall.copyWith(
            color: SoteriaColors.gold,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xxl),
      ],
    );
  }
}

class _XpBadge extends StatelessWidget {
  const _XpBadge({required this.xp});
  final int xp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: SoteriaColors.primary.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt_rounded, color: SoteriaColors.primary, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            '+$xp XP',
            style: context.titleMedium.copyWith(
              color: SoteriaColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _PerformanceSummary extends StatelessWidget {
  const _PerformanceSummary({required this.result});
  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: SoteriaSpacing.md,
        crossAxisSpacing: SoteriaSpacing.md,
        childAspectRatio: 2.5,
        children: [
          _StatCard(
            label: 'ACCURACY',
            value: '${(result.accuracy * 100).round()}%',
            icon: Icons.track_changes_rounded,
            color: SoteriaColors.secondary,
          ),
          _StatCard(
            label: 'BEST STREAK',
            value: result.longestStreak.toString(),
            icon: Icons.fireplace_rounded,
            color: SoteriaColors.warning,
          ),
          _StatCard(
            label: 'AVG SPEED',
            value: '${(result.averageResponseTime.inMilliseconds / 1000).toStringAsFixed(1)}s',
            icon: Icons.timer_rounded,
            color: Colors.white70,
          ),
          _StatCard(
            label: 'CORRECT',
            value: '${result.correctAnswers}/${result.totalQuestions}',
            icon: Icons.check_circle_rounded,
            color: SoteriaColors.success,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(SoteriaRadius.lg),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: context.titleLarge.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: context.labelSmall.copyWith(
                  color: Colors.white38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuestionResultCard extends StatelessWidget {
  const _QuestionResultCard({required this.result});
  final QuestionResult result;

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _getStatusColor();
    final IconData statusIcon = _getStatusIcon();

    return Container(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(SoteriaRadius.lg),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Q${result.questionNumber}',
                style: context.labelSmall.copyWith(
                  color: Colors.white38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(statusIcon, color: statusColor, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                result.outcome.name.toUpperCase(),
                style: context.labelSmall.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            result.questionText,
            style: context.bodyLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (result.outcome != QuestionOutcome.correct) ...[
            SizedBox(height: SoteriaSpacing.md),
            if (result.selectedOptionText != null) ...[
              _AnswerRow(
                label: 'YOURS:',
                text: result.selectedOptionText!,
                color: SoteriaColors.error,
              ),
              SizedBox(height: 4.h),
            ],
            _AnswerRow(
              label: 'CORRECT:',
              text: result.correctOptionText,
              color: SoteriaColors.success,
            ),
          ],
          if (result.explanation != null) ...[
            SizedBox(height: SoteriaSpacing.lg),
            Container(
              padding: EdgeInsets.all(SoteriaSpacing.md),
              decoration: BoxDecoration(
                color: SoteriaColors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(SoteriaRadius.md),
              ),
              child: Text(
                result.explanation!,
                style: context.bodySmall.copyWith(color: Colors.white70),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (result.outcome) {
      case QuestionOutcome.correct:
        return SoteriaColors.success;
      case QuestionOutcome.incorrect:
        return SoteriaColors.error;
      case QuestionOutcome.skipped:
        return Colors.white38;
      case QuestionOutcome.timedOut:
        return SoteriaColors.warning;
    }
  }

  IconData _getStatusIcon() {
    switch (result.outcome) {
      case QuestionOutcome.correct:
        return Icons.check_circle_rounded;
      case QuestionOutcome.incorrect:
        return Icons.cancel_rounded;
      case QuestionOutcome.skipped:
        return Icons.skip_next_rounded;
      case QuestionOutcome.timedOut:
        return Icons.timer_off_rounded;
    }
  }
}

class _AnswerRow extends StatelessWidget {
  const _AnswerRow({
    required this.label,
    required this.text,
    required this.color,
  });
  final String label;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70.w,
          child: Text(
            label,
            style: context.labelSmall.copyWith(
              color: Colors.white38,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: context.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultActions extends ConsumerWidget {
  const _ResultActions({required this.result});
  final QuizResult result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              ref.read(quizControllerProvider.notifier).resetQuiz();
              // In a real app, we'd trigger a new session based on previous config
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
