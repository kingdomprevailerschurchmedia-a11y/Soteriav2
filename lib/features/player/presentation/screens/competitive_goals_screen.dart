import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/player/domain/models/competitive_goal.dart';
import 'package:soteria/features/player/presentation/providers/goal_providers.dart';
import 'package:soteria/features/player/presentation/widgets/goals/competitive_goal_card.dart';

class CompetitiveGoalsScreen extends ConsumerWidget {
  const CompetitiveGoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger evaluation and refresh
    ref.watch(goalEvaluationProvider);
    ref.watch(goalRefreshProvider);

    final dailyGoals = ref.watch(dailyGoalsProvider);
    final weeklyGoals = ref.watch(weeklyGoalsProvider);
    final seasonalGoals = ref.watch(seasonalGoalsProvider);
    final careerGoals = ref.watch(careerGoalsProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('Missions & Goals'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          _buildSection(context, 'DAILY OBJECTIVES', dailyGoals),
          _buildSection(context, 'WEEKLY CHALLENGES', weeklyGoals),
          _buildSection(context, 'SEASONAL GOALS', seasonalGoals),
          _buildSection(context, 'CAREER MILESTONES', careerGoals),
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    AsyncValue<List<CompetitiveGoal>> goalsAsync,
  ) {
    return goalsAsync.when(
      data: (goals) {
        if (goals.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: SoteriaSpacing.lg,
            vertical: SoteriaSpacing.md,
          ),
          sliver: MultiSliver(
            children: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
                  child: Text(
                    title,
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.textSecondary,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
                    child: CompetitiveGoalCard(
                      goal: goals[index],
                      onTap: () => _showGoalDetails(context, goals[index]),
                    ),
                  ),
                  childCount: goals.length,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(SoteriaSpacing.xl),
          child: const Center(
            child: CircularProgressIndicator(color: SoteriaColors.primary),
          ),
        ),
      ),
      error: (e, _) => SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(SoteriaSpacing.xl),
          child: Center(child: Text('Error loading goals: $e')),
        ),
      ),
    );
  }

  void _showGoalDetails(BuildContext context, CompetitiveGoal goal) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _GoalDetailView(goal: goal),
    );
  }
}

class MultiSliver extends StatelessWidget {
  final List<Widget> children;
  const MultiSliver({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: children);
  }
}

class _GoalDetailView extends StatelessWidget {
  final CompetitiveGoal goal;
  const _GoalDetailView({required this.goal});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        color: SoteriaColors.backgroundTopLeft,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.all(SoteriaSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Text(
            goal.title,
            style: context.headlineSmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: SoteriaSpacing.sm),
          Text(
            goal.description,
            style: context.bodyLarge.copyWith(color: Colors.white70),
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          _buildInfoRow(
            context,
            'PROGRESS',
            '${goal.currentProgress.toInt()} / ${goal.target.toInt()}',
          ),
          SizedBox(height: SoteriaSpacing.md),
          _buildInfoRow(context, 'STATUS', goal.status.name.toUpperCase()),
          if (goal.rewardId != null) ...[
            SizedBox(height: SoteriaSpacing.md),
            _buildInfoRow(context, 'REWARD', 'Available upon completion'),
          ],
          const Spacer(),
          if (goal.isActive)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CONTINUE MISSION'),
              ),
            ),
          SizedBox(height: SoteriaSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.labelSmall.copyWith(color: SoteriaColors.muted),
        ),
        Text(
          value,
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
