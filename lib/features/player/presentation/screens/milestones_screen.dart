import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../providers/milestone_providers.dart';
import '../widgets/milestone_card.dart';
import '../../domain/models/milestone.dart';

class MilestonesScreen extends ConsumerWidget {
  const MilestonesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger evaluation when landing on the screen
    ref.watch(milestoneEvaluationProvider);

    final progressAsync = ref.watch(milestoneProgressProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: progressAsync.when(
        data: (progressList) => _buildContent(context, progressList),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => _buildError(context, ref),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<MilestoneProgress> progressList,
  ) {
    final completedCount = progressList.where((p) => p.isCompleted).length;
    final inProgress = progressList.where((p) => !p.isCompleted).toList();
    final completed = progressList.where((p) => p.isCompleted).toList();

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      children: [
        _buildHeader(context, completedCount, progressList.length),
        if (inProgress.isNotEmpty) ...[
          _buildSectionHeader(context, 'IN PROGRESS'),
          ...inProgress.map(
            (p) => Padding(
              padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
              child: SoteriaFadeIn(child: MilestoneCard(progress: p)),
            ),
          ),
        ],
        if (completed.isNotEmpty) ...[
          _buildSectionHeader(context, 'COMPLETED'),
          ...completed.map(
            (p) => Padding(
              padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
              child: SoteriaFadeIn(child: MilestoneCard(progress: p)),
            ),
          ),
        ],
        SizedBox(height: SoteriaSpacing.xxxl),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, int completed, int total) {
    final progress = total > 0 ? completed / total : 0.0;
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.xl),
      child: Column(
        children: [
          Text(
            '${(progress * 100).toInt()}%',
            style: context.displaySmall.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            'CAREER COMPLETION',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            '$completed of $total achievements unlocked',
            style: context.bodyMedium.copyWith(
              color: SoteriaColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: SoteriaSpacing.lg,
        bottom: SoteriaSpacing.md,
      ),
      child: Text(
        title,
        style: context.labelSmall.copyWith(
          color: SoteriaColors.muted,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: SoteriaColors.error,
            size: 48,
          ),
          SizedBox(height: SoteriaSpacing.md),
          const Text('Failed to load achievements'),
          TextButton(
            onPressed: () => ref.refresh(milestoneProgressProvider),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
