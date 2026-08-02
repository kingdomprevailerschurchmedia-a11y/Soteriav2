import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_type.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_status.dart';
import 'package:soteria/features/gameplay_engine/lifelines/widgets/lifeline_button.dart';
import 'package:soteria/features/gameplay_engine/lifelines/widgets/audience_chart.dart';

class LifelinePreviewGallery extends StatelessWidget {
  const LifelinePreviewGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            context,
            'Lifeline Buttons',
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LifelineButton(type: LifelineType.fiftyFifty, onTap: () {}),
                LifelineButton(type: LifelineType.pauseTimer, onTap: () {}),
                LifelineButton(type: LifelineType.askAudience, onTap: () {}),
              ],
            ),
          ),
          _buildSection(
            context,
            'Lifeline States',
            Wrap(
              spacing: 24,
              children: [
                _LabelledButton(
                  label: 'Available',
                  status: LifelineStatus.available,
                ),
                _LabelledButton(label: 'Used', status: LifelineStatus.used),
                _LabelledButton(label: 'Locked', status: LifelineStatus.locked),
                _LabelledButton(
                  label: 'Premium',
                  status: LifelineStatus.premiumLocked,
                ),
              ],
            ),
          ),
          _buildSection(
            context,
            'Audience Simulation',
            const AudienceChart(
              votes: {'a': 0.72, 'b': 0.08, 'c': 0.15, 'd': 0.05},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.labelLarge.copyWith(color: SoteriaColors.gold),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        child,
        SizedBox(height: SoteriaSpacing.xxl),
      ],
    );
  }
}

class _LabelledButton extends StatelessWidget {
  const _LabelledButton({required this.label, required this.status});
  final String label;
  final LifelineStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LifelineButton(
          type: LifelineType.fiftyFifty,
          onTap: () {},
          status: status,
        ),
        SizedBox(height: SoteriaSpacing.xs),
        Text(
          label,
          style: context.bodySmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
