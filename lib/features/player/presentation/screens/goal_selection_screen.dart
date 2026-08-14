import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../domain/models/competitive_goal.dart';
import '../providers/goal_providers.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../domain/config/progression_config.dart';

class GoalSelectionScreen extends ConsumerWidget {
  const GoalSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('SET PERSONAL TARGET'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        children: [
          _buildSectionHeader(context, 'RANK GOALS'),
          ...ProgressionConfig.rankTiers
              .where((t) => t.id != 'unranked')
              .map((tier) => _GoalOptionCard(
                    title: 'Reach ${tier.name}',
                    description: 'Climb the ladder to join the ${tier.name} tier.',
                    icon: Icons.military_tech_rounded,
                    onSelect: () => _createRankGoal(context, ref, tier.name),
                  )),
          SizedBox(height: SoteriaSpacing.xl),
          _buildSectionHeader(context, 'PERFORMANCE GOALS'),
          _GoalOptionCard(
            title: 'Win 50 Matches',
            description: 'Prove your dominance by winning 50 competitive games.',
            icon: Icons.emoji_events_rounded,
            onSelect: () => _createWinGoal(context, ref, 50),
          ),
          _GoalOptionCard(
            title: '90% Accuracy',
            description: 'Maintain surgical precision in your next 10 matches.',
            icon: Icons.track_changes_rounded,
            onSelect: () => _createAccuracyGoal(context, ref, 0.9),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Text(
        title,
        style: context.labelSmall.copyWith(
          color: SoteriaColors.textSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  void _createRankGoal(BuildContext context, WidgetRef ref, String tierName) {
    _handleCreation(
      context,
      ref,
      CompetitiveGoal(
        id: const Uuid().v4(),
        userId: ref.read(authRepositoryProvider).currentUserId!,
        type: GoalType.career,
        category: GoalCategory.rank,
        title: 'Reach $tierName',
        description: 'Earn enough RP to reach the $tierName tier.',
        target: 1,
        currentProgress: 0,
        status: GoalStatus.active,
        startAt: DateTime.now(),
        endAt: DateTime.now().add(const Duration(days: 365)),
        metadata: {'targetTier': tierName},
      ),
    );
  }

  void _createWinGoal(BuildContext context, WidgetRef ref, int targetWins) {
    _handleCreation(
      context,
      ref,
      CompetitiveGoal(
        id: const Uuid().v4(),
        userId: ref.read(authRepositoryProvider).currentUserId!,
        type: GoalType.career,
        category: GoalCategory.win,
        title: 'Win $targetWins Matches',
        description: 'Win $targetWins competitive matches across any mode.',
        target: targetWins.toDouble(),
        currentProgress: 0,
        status: GoalStatus.active,
        startAt: DateTime.now(),
        endAt: DateTime.now().add(const Duration(days: 90)),
      ),
    );
  }

  void _createAccuracyGoal(BuildContext context, WidgetRef ref, double accuracy) {
    _handleCreation(
      context,
      ref,
      CompetitiveGoal(
        id: const Uuid().v4(),
        userId: ref.read(authRepositoryProvider).currentUserId!,
        type: GoalType.career,
        category: GoalCategory.personalBest,
        title: '${(accuracy * 100).toInt()}% Accuracy',
        description: 'Achieve a career accuracy of ${(accuracy * 100).toInt()}%.',
        target: accuracy,
        currentProgress: 0,
        status: GoalStatus.active,
        startAt: DateTime.now(),
        endAt: DateTime.now().add(const Duration(days: 30)),
      ),
    );
  }

  Future<void> _handleCreation(
    BuildContext context,
    WidgetRef ref,
    CompetitiveGoal goal,
  ) async {
    try {
      await ref.read(goalRepositoryProvider).createGoal(goal);
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Personal target set!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error setting goal: $e')),
        );
      }
    }
  }
}

class _GoalOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onSelect;

  const _GoalOptionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      color: SoteriaColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SoteriaSpacing.md),
        border: Border.all(color: SoteriaColors.border),
      ),
      child: ListTile(
        onTap: onSelect,
        leading: Icon(icon, color: SoteriaColors.primary, size: 32.w),
        title: Text(title, style: context.titleMedium),
        subtitle: Text(description, style: context.bodySmall),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
