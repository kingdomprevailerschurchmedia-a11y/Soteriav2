import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../domain/models/competitive_goal.dart';
import '../providers/goal_providers.dart';

class GoalHistoryScreen extends ConsumerWidget {
  const GoalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(goalHistoryProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('GOAL HISTORY'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: historyAsync.when(
        data: (goals) => _buildList(context, goals),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<CompetitiveGoal> goals) {
    if (goals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_toggle_off_rounded, size: 64.w, color: SoteriaColors.muted),
            SizedBox(height: SoteriaSpacing.md),
            const Text('No goal history found.'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final goal = goals[index];
        return _HistoryGoalCard(goal: goal);
      },
    );
  }
}

class _HistoryGoalCard extends StatelessWidget {
  final CompetitiveGoal goal;

  const _HistoryGoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    final isCompleted = goal.status == GoalStatus.completed || goal.status == GoalStatus.claimed;
    final color = isCompleted ? SoteriaColors.success : SoteriaColors.error;

    return Card(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      color: SoteriaColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SoteriaSpacing.md),
        border: Border.all(color: SoteriaColors.border),
      ),
      child: ListTile(
        leading: Icon(
          isCompleted ? Icons.check_circle_rounded : Icons.cancel_rounded,
          color: color,
        ),
        title: Text(goal.title, style: context.titleMedium),
        subtitle: Text(
          DateFormat('MMM d, yyyy').format(goal.endAt),
          style: context.bodySmall.copyWith(color: SoteriaColors.textSecondary),
        ),
        trailing: Text(
          goal.status.name.toUpperCase(),
          style: context.labelSmall.copyWith(color: color),
        ),
      ),
    );
  }
}
