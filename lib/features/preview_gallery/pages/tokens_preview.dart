import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/features/preview_gallery/widgets/preview_wrapper.dart';

class TokensPreview extends StatelessWidget {
  const TokensPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewWrapper(
      title: 'Design Tokens',
      builder: (context, state) {
        return ListView(
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          children: [
            _buildSection('Colors', _buildColorPalette()),
            _buildSection('Typography', _buildTypographySamples(context)),
            _buildSection('Spacing', _buildSpacingSamples()),
            _buildSection('Radius', _buildRadiusSamples()),
          ],
        );
      },
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: SoteriaColors.muted,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(color: SoteriaColors.border),
        SizedBox(height: SoteriaSpacing.md),
        content,
        SizedBox(height: SoteriaSpacing.xxl),
      ],
    );
  }

  Widget _buildColorPalette() {
    final colors = {
      'Primary': SoteriaColors.primary,
      'Secondary': SoteriaColors.secondary,
      'Gold': SoteriaColors.gold,
      'Surface': SoteriaColors.surface,
      'Success': SoteriaColors.success,
      'Error': SoteriaColors.error,
    };

    return Wrap(
      spacing: SoteriaSpacing.md,
      runSpacing: SoteriaSpacing.md,
      children: colors.entries.map((e) {
        return Column(
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: e.value,
                borderRadius: SoteriaRadius.brMd,
                border: Border.all(color: Colors.white10),
              ),
            ),
            SizedBox(height: 4.h),
            Text(e.key, style: const TextStyle(fontSize: 10)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTypographySamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Display Large', style: context.displayLarge),
        Text('Headline Medium', style: context.headlineMedium),
        Text('Title Large', style: context.titleLarge),
        Text('Body Large', style: context.bodyLarge),
        Text('Label Small', style: context.labelSmall),
      ],
    );
  }

  Widget _buildSpacingSamples() {
    final spacing = {
      'XS (4)': SoteriaSpacing.xs,
      'SM (8)': SoteriaSpacing.sm,
      'MD (16)': SoteriaSpacing.md,
      'LG (24)': SoteriaSpacing.lg,
      'XL (32)': SoteriaSpacing.xl,
    };

    return Column(
      children: spacing.entries.map((e) {
        return Row(
          children: [
            Text(e.key, style: const TextStyle(fontSize: 12)),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(
              child: Container(
                height: 12,
                width: e.value,
                color: SoteriaColors.primary.withValues(alpha: 0.3),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildRadiusSamples() {
    final radii = {
      'SM (8)': SoteriaRadius.brSm,
      'MD (12)': SoteriaRadius.brMd,
      'LG (16)': SoteriaRadius.brLg,
      'XL (24)': SoteriaRadius.brXl,
    };

    return Wrap(
      spacing: SoteriaSpacing.md,
      children: radii.entries.map((e) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: SoteriaColors.surface,
            borderRadius: e.value,
            border: Border.all(color: SoteriaColors.primary),
          ),
          child: Center(
            child: Text(
              e.key.split(' ')[0],
              style: const TextStyle(fontSize: 10),
            ),
          ),
        );
      }).toList(),
    );
  }
}
