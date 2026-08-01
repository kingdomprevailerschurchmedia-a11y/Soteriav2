import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/cards/soteria_card.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/feedback/soteria_linear_progress.dart';
import 'package:soteria/features/personalization/widgets/selection_card.dart';

class PersonalizationPreviewPage extends StatelessWidget {
  const PersonalizationPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        SoteriaButton.primary(
          label: 'Launch Full Personalization',
          onPressed: () => context.push(SoteriaRoutes.personalization),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        
        Text('Progress Bar', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaCard(
          child: Column(
            children: [
              SoteriaLinearProgress(progress: 0.2, color: SoteriaColors.gold),
              SizedBox(height: 16),
              SoteriaLinearProgress(progress: 0.6, color: SoteriaColors.gold),
              SizedBox(height: 16),
              SoteriaLinearProgress(progress: 1.0, color: SoteriaColors.gold),
            ],
          ),
        ),
        
        SizedBox(height: SoteriaSpacing.xl),
        Text('Selection Cards', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: SoteriaSpacing.md),
        Column(
          children: [
            SelectionCard(
              title: 'Not Selected',
              icon: Icons.school_rounded,
              isSelected: false,
              onTap: () {},
            ),
            const SizedBox(height: 12),
            SelectionCard(
              title: 'Selected State',
              subtitle: 'With additional description',
              icon: Icons.workspace_premium_rounded,
              isSelected: true,
              onTap: () {},
            ),
          ],
        ),
        
        SizedBox(height: SoteriaSpacing.xl),
        Text('Responsiveness', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Adaptive Grid', style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
              const SizedBox(height: 8),
              const Text('The Interest selection uses a Wrap widget to automatically adapt chip layout based on screen width.'),
            ],
          ),
        ),
      ],
    );
  }
}
