import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/gradients/soteria_gradients.dart';

class GradientsPreviewPage extends StatelessWidget {
  const GradientsPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        _buildGradientItem(
          'Primary Background',
          SoteriaGradients.primaryBackground,
        ),
        _buildGradientItem('Competition', SoteriaGradients.competition),
        _buildGradientItem('Reward (Premium Gold)', SoteriaGradients.reward),
        _buildGradientItem('Card Subtle', SoteriaGradients.card),
        _buildGradientItem('Button Action', SoteriaGradients.button),
      ],
    );
  }

  Widget _buildGradientItem(String name, LinearGradient gradient) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: SoteriaTypography.title),
        SizedBox(height: SoteriaSpacing.sm),
        Container(
          height: 100.0.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),
      ],
    );
  }
}
