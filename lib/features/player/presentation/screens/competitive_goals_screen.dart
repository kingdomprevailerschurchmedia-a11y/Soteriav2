import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../domain/models/goal.dart';
import '../providers/goal_providers.dart';
import '../widgets/goals/competitive_goal_card.dart';
import '../widgets/goals/next_goal_card.dart';
import 'goal_details_screen.dart';
import 'goal_selection_screen.dart';
import 'goal_history_screen.dart';
import 'competitive_progression_screen.dart';

class CompetitiveGoalsScreen extends ConsumerWidget {
  const CompetitiveGoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger evaluation and refresh
    ref.watch(goalEvaluationProvider);
    ref.watch(goalRefreshProvider);

    final nextGoalAsync = ref.watch(nextGoalProvider);
    final dailyGoals = ref.watch(dailyGoalsProvider);
    final weeklyGoals = ref.watch(weeklyGoalsProvider);
    final seasonalGoals = ref.watch(seasonalGoalsProvider);
    final careerGoals = ref.watch(careerGoalsProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('COMPETITIVE GOALS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const GoalHistoryScreen()),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Next Goal Hero
          nextGoalAsync.when(
            data: (progress) => progress != null
                ? SliverPadding(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
                    sliver: SliverToBoxAdapter(
                      child: NextGoalCard(
                        progress: progress,
                        onTap: () => _navigateToDetails(context, progress),
                      ),
                    ),
                  )
                : const SliverToBoxAdapter(child: SizedBox.shrink()),
            loading: () => const SliverToBoxAdapter(child: LinearProgressIndicator()),
            error: (_, __) => const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),

          // Quick Actions
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: _ActionCard(
                      label: 'ROADMAP',
                      icon: Icons.map_outlined,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CompetitiveProgressionScreen()),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _ActionCard(
                      label: 'SET TARGET',
                      icon: Icons.add_circle_outline_rounded,
                      color: SoteriaColors.primary,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const GoalSelectionScreen()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          _buildSection(context, 'DAILY OBJECTIVES', dailyGoals),
          _buildSection(context, 'WEEKLY GOALS', weeklyGoals),
          _buildSection(context, 'SEASONAL GOALS', seasonalGoals),
          _buildSection(context, 'CAREER MILESTONES', careerGoals),

          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    AsyncValue<List<GoalProgress>> goalsAsync,
  ) {
    return goalsAsync.when(
      data: (goals) {
        if (goals.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    title,
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.textSecondary,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w900,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: CompetitiveGoalCard(
                      progress: goals[index],
                      onTap: () => _navigateToDetails(context, goals[index]),
                    ),
                  ),
                  childCount: goals.length,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
      error: (e, _) => const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }

  void _navigateToDetails(BuildContext context, GoalProgress progress) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (_) => GoalDetailsScreen(goal: progress.playerState!)),
    // );
  }
}

class _ActionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _ActionCard({
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: SoteriaColors.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color?.withOpacity(0.3) ?? SoteriaColors.border.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color ?? SoteriaColors.textPrimary, size: 20.w),
            SizedBox(height: 4.h),
            Text(
              label,
              style: context.labelSmall.copyWith(
                color: color ?? SoteriaColors.textPrimary,
                fontWeight: FontWeight.w900,
                fontSize: 10.sp,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
