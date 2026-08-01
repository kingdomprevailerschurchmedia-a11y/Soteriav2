import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/overlays/soteria_dialog.dart';
import 'package:soteria/core/widgets/overlays/soteria_bottom_sheet.dart';
import 'package:soteria/core/widgets/typography/soteria_text.dart';

class OverlaysPreviewPage extends StatelessWidget {
  const OverlaysPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        SoteriaButton.primary(
          label: 'Show Dialog',
          onPressed: () => SoteriaDialog.show(
            context,
            title: 'Confirm Action',
            message: 'Are you sure you want to proceed with this operation?',
            icon: Icons.help_outline_rounded,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.secondary(
          label: 'Show Bottom Sheet',
          onPressed: () => SoteriaBottomSheet.show(
            context,
            title: 'Options',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
              child: const SoteriaText.body('Select one of the following options to continue.'),
            ),
          ),
        ),
      ],
    );
  }
}
