import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/buttons/soteria_icon_button.dart';
import 'package:soteria/core/widgets/typography/soteria_text.dart';

class ButtonsPreviewPage extends StatelessWidget {
  const ButtonsPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        const SoteriaText.label('PRIMARY BUTTON'),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.primary(label: 'Primary Action', onPressed: () {}),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('SECONDARY BUTTON'),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.secondary(label: 'Secondary Action', onPressed: () {}),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('GHOST BUTTON'),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.ghost(label: 'Outline Action', onPressed: () {}),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('LOADING STATE'),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.primary(
          label: 'Loading...',
          isLoading: true,
          onPressed: () {},
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('DISABLED STATE'),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaButton.primary(label: 'Disabled Action', onPressed: null),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('ICON BUTTONS'),
        SizedBox(height: SoteriaSpacing.md),
        Row(
          children: [
            SoteriaIconButton(icon: Icons.add, onPressed: () {}),
            SizedBox(width: SoteriaSpacing.md),
            SoteriaIconButton(
              icon: Icons.share,
              isGlass: true,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('TEXT BUTTON'),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.text(label: 'Need help?', onPressed: () {}),
      ],
    );
  }
}
