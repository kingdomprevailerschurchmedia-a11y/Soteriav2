import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_text.dart';
import 'package:soteria/core/widgets/typography/soteria_gradient_text.dart';
import 'package:soteria/core/widgets/typography/soteria_divider.dart';

class TypographyPreviewPage extends StatelessWidget {
  const TypographyPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        const SoteriaText.displayLarge('Display L'),
        const SoteriaText.displayMedium('Display M'),
        const SoteriaDivider(),
        const SoteriaText.headline('Headline Text'),
        const SoteriaText.title('Title Text'),
        const SoteriaText.body('Body text for paragraphs and descriptions.'),
        const SoteriaText.label('LABEL TEXT'),
        const SoteriaText.caption('Caption text for small notes.'),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('GRADIENT TEXT'),
        SoteriaGradientText(
          'Competitive Premium',
          style: SoteriaTypography.displayMedium,
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('GRADIENT DIVIDER'),
        const SoteriaDivider(isGradient: true),
      ],
    );
  }
}
