import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/core/design_system/blur/soteria_blur.dart';

class SurfacesPreviewPage extends StatelessWidget {
  const SurfacesPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        _buildSurfaceSection(
          'Glassmorphism',
          'Subtle frosted glass effects with blurred backgrounds.',
          GlassSurface(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            child: Column(
              children: [
                const Text(
                  'Standard Glass',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: SoteriaSpacing.sm),
                const Text(
                  'Blurred backdrop with 8% opacity white overlay.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        _buildSurfaceSection(
          'High Blur Glass',
          'More obscured background for better legibility on busy screens.',
          GlassSurface(
            blur: SoteriaBlur.high,
            opacity: 0.12,
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            child: const Text(
              'High Blur / High Opacity',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        _buildSurfaceSection(
          'Solid Surfaces',
          'Non-transparent surface levels.',
          Container(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            decoration: BoxDecoration(
              color: SoteriaColors.elevatedSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Elevated Surface (Solid)',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSurfaceSection(String title, String subtitle, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: SoteriaTypography.title),
        Text(subtitle, style: SoteriaTypography.caption),
        SizedBox(height: SoteriaSpacing.md),
        content,
        SizedBox(height: SoteriaSpacing.xl),
      ],
    );
  }
}
