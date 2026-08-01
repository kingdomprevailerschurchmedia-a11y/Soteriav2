import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';

class LightingPreviewPage extends StatelessWidget {
  const LightingPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: -50,
          left: -50,
          child: AmbientGlow(color: SoteriaColors.primary, size: 300),
        ),
        const Positioned(
          bottom: 100,
          right: -100,
          child: AmbientGlow(color: SoteriaColors.secondary, size: 400, opacity: 0.2),
        ),
        const Positioned(
          top: 200,
          right: 50,
          child: AmbientGlow(color: SoteriaColors.gold, size: 150, blur: 50, opacity: 0.1),
        ),
        ListView(
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          children: [
            Text(
              'Ambient Lighting Effects',
              style: SoteriaTypography.headline,
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              'These glows are created using AmbientGlow widgets with BackdropFilters. They should be used sparingly to create depth and atmosphere.',
              style: SoteriaTypography.body,
            ),
          ],
        ),
      ],
    );
  }
}
