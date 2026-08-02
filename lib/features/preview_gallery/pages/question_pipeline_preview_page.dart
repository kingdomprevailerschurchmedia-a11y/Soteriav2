import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/gameplay_engine/widgets/game_glass_card.dart';

class QuestionPipelinePreviewPage extends StatelessWidget {
  const QuestionPipelinePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPreviewSection(
            context,
            'Question Loading',
            const _LoadingStatePreview(),
          ),
          _buildPreviewSection(
            context,
            'Empty State (No Questions)',
            const _EmptyStatePreview(),
          ),
          _buildPreviewSection(
            context,
            'Sync / Offline State',
            const _OfflineStatePreview(),
          ),
          _buildPreviewSection(
            context,
            'Error State',
            const _ErrorStatePreview(),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewSection(
    BuildContext context,
    String title,
    Widget child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.labelLarge.copyWith(color: SoteriaColors.gold),
        ),
        SizedBox(height: SoteriaSpacing.md),
        child,
        SizedBox(height: SoteriaSpacing.xl),
        const Divider(color: Colors.white10),
        SizedBox(height: SoteriaSpacing.xl),
      ],
    );
  }
}

class _LoadingStatePreview extends StatelessWidget {
  const _LoadingStatePreview();

  @override
  Widget build(BuildContext context) {
    return GameGlassCard(
      child: Column(
        children: [
          const CircularProgressIndicator(color: SoteriaColors.primary),
          SizedBox(height: SoteriaSpacing.md),
          Text('PREFETCHING QUESTIONS...', style: context.bodySmall),
        ],
      ),
    );
  }
}

class _EmptyStatePreview extends StatelessWidget {
  const _EmptyStatePreview();

  @override
  Widget build(BuildContext context) {
    return GameGlassCard(
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              color: SoteriaColors.muted,
              size: 48,
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text('NO QUESTIONS FOUND', style: context.titleLarge),
            Text(
              'Check your filters or internet connection.',
              style: context.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _OfflineStatePreview extends StatelessWidget {
  const _OfflineStatePreview();

  @override
  Widget build(BuildContext context) {
    return GameGlassCard(
      borderColor: Colors.orange.withValues(alpha: 0.3),
      child: Row(
        children: [
          const Icon(Icons.cloud_off_rounded, color: Colors.orange),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OFFLINE MODE',
                  style: context.titleLarge.copyWith(color: Colors.orange),
                ),
                Text(
                  'Playing from 25 cached questions.',
                  style: context.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorStatePreview extends StatelessWidget {
  const _ErrorStatePreview();

  @override
  Widget build(BuildContext context) {
    return GameGlassCard(
      borderColor: SoteriaColors.error.withValues(alpha: 0.3),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: SoteriaColors.error,
            size: 32,
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            'SYNC FAILED',
            style: context.titleLarge.copyWith(color: SoteriaColors.error),
          ),
          SizedBox(height: SoteriaSpacing.sm),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: SoteriaColors.error,
            ),
            child: const Text('RETRY SYNC'),
          ),
        ],
      ),
    );
  }
}
