import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/features/preview_gallery/widgets/preview_wrapper.dart';

class ButtonsPreview extends StatelessWidget {
  const ButtonsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewWrapper(
      title: 'Buttons Component',
      builder: (context, state) {
        return ListView(
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          children: [
            _buildVariantGroup('Primary', SoteriaButtonVariant.primary),
            _buildVariantGroup('Secondary', SoteriaButtonVariant.secondary),
            _buildVariantGroup('Ghost', SoteriaButtonVariant.ghost),
            _buildVariantGroup('Danger', SoteriaButtonVariant.danger),
            _buildVariantGroup('Outline', SoteriaButtonVariant.outline),
          ],
        );
      },
    );
  }

  Widget _buildVariantGroup(String title, SoteriaButtonVariant variant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Divider(),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton(
          label: '$title Button',
          variant: variant,
          onPressed: () {},
        ),
        SizedBox(height: SoteriaSpacing.sm),
        Row(
          children: [
            Expanded(
              child: SoteriaButton(
                label: 'Loading',
                variant: variant,
                isLoading: true,
                onPressed: () {},
              ),
            ),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(
              child: SoteriaButton(
                label: 'Disabled',
                variant: variant,
                onPressed: null,
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.xl),
      ],
    );
  }
}
