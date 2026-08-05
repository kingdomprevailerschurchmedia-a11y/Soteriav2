import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/feedback/soteria_badge.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/widgets/feedback/soteria_linear_progress.dart';
import 'package:soteria/core/widgets/feedback/soteria_shimmer.dart';
import 'package:soteria/core/widgets/feedback/soteria_empty_state.dart';
import 'package:soteria/core/widgets/feedback/soteria_error_widget.dart';
import 'package:soteria/core/design_system/components/soteria_text.dart';

class FeedbackPreviewPage extends StatelessWidget {
  const FeedbackPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        const SoteriaText.label('BADGES'),
        SizedBox(height: SoteriaSpacing.md),
        const Wrap(
          spacing: SoteriaSpacing.smStatic,
          runSpacing: SoteriaSpacing.smStatic,
          children: [
            SoteriaBadge(label: 'New'),
            SoteriaBadge(label: 'Premium', variant: SoteriaBadgeVariant.gold),
            SoteriaBadge(
              label: 'Success',
              variant: SoteriaBadgeVariant.success,
            ),
            SoteriaBadge(label: 'Error', variant: SoteriaBadgeVariant.error),
          ],
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('LOADERS'),
        SizedBox(height: SoteriaSpacing.md),
        const Row(
          children: [
            SoteriaLoader(),
            SizedBox(width: SoteriaSpacing.xlStatic),
            Expanded(child: SoteriaLinearProgress(progress: 0.6)),
          ],
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('SHIMMER'),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaShimmer(width: double.infinity, height: 60.0.h),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('EMPTY STATE'),
        SizedBox(height: SoteriaSpacing.md),
        Container(
          height: 300.0.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const SoteriaEmptyState(
            title: 'No Items Found',
            subtitle: 'Start by adding a new entry to your collection.',
            icon: Icons.folder_open_rounded,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('ERROR WIDGET'),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaErrorWidget(message: 'Secure link failed. Please retry.'),
      ],
    );
  }
}
