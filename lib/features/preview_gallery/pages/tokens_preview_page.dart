import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';

class TokensPreviewPage extends StatelessWidget {
  const TokensPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        _buildSection(
          title: 'Typography',
          children: [
            Text('Display Large', style: SoteriaTypography.displayLarge),
            SizedBox(height: SoteriaSpacing.sm),
            Text('Display Medium', style: SoteriaTypography.displayMedium),
            SizedBox(height: SoteriaSpacing.md),
            Text('Headline', style: SoteriaTypography.headline),
            SizedBox(height: SoteriaSpacing.md),
            Text('Title', style: SoteriaTypography.title),
            SizedBox(height: SoteriaSpacing.md),
            Text('Body', style: SoteriaTypography.body),
            SizedBox(height: SoteriaSpacing.md),
            Text('Label', style: SoteriaTypography.label),
            SizedBox(height: SoteriaSpacing.md),
            Text('Caption', style: SoteriaTypography.caption),
          ],
        ),
        SizedBox(height: SoteriaSpacing.xl),
        _buildSection(
          title: 'Colors',
          children: [
            _buildColorItem('Primary', SoteriaColors.primary),
            _buildColorItem('Secondary', SoteriaColors.secondary),
            _buildColorItem('Gold', SoteriaColors.gold),
            _buildColorItem('Surface', SoteriaColors.surface),
            _buildColorItem('Elevated', SoteriaColors.elevatedSurface),
            _buildColorItem('Text Primary', SoteriaColors.textPrimary),
            _buildColorItem('Text Secondary', SoteriaColors.textSecondary),
          ],
        ),
        SizedBox(height: SoteriaSpacing.xl),
        _buildSection(
          title: 'Radius',
          children: [
            Wrap(
              spacing: SoteriaSpacing.md,
              runSpacing: SoteriaSpacing.md,
              children: [
                _buildRadiusBox('XS', SoteriaRadius.brXs),
                _buildRadiusBox('SM', SoteriaRadius.brSm),
                _buildRadiusBox('MD', SoteriaRadius.brMd),
                _buildRadiusBox('LG', SoteriaRadius.brLg),
                _buildRadiusBox('XL', SoteriaRadius.brXl),
                _buildRadiusBox('Full', SoteriaRadius.brFull),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: SoteriaTypography.label.copyWith(color: SoteriaColors.gold),
        ),
        SizedBox(height: SoteriaSpacing.md),
        ...children,
      ],
    );
  }

  Widget _buildColorItem(String name, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 40.0.w,
            height: 40.0.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: SoteriaRadius.brSm,
              border: Border.all(color: SoteriaColors.hints, width: 0.5),
            ),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Text(name, style: SoteriaTypography.body),
          const Spacer(),
          Text(
            '#${color.toARGB32().toRadixString(16).toUpperCase().substring(2)}',
            style: SoteriaTypography.caption,
          ),
        ],
      ),
    );
  }

  Widget _buildRadiusBox(String label, BorderRadius radius) {
    return Container(
      width: 60.0.w,
      height: 60.0.w,
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withValues(alpha: 0.2),
        borderRadius: radius,
        border: Border.all(color: SoteriaColors.primary),
      ),
      alignment: Alignment.center,
      child: Text(label, style: SoteriaTypography.caption),
    );
  }
}
