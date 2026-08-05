import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/components/soteria_text.dart';
import 'package:soteria/core/widgets/feedback/soteria_error_widget.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';

class StartupPreviewPage extends StatelessWidget {
  const StartupPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        const SoteriaText.label('LOADING STATE'),
        SizedBox(height: SoteriaSpacing.md),
        const Center(child: SoteriaLoader(size: 40)),

        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('BOOTSTRAP ERROR'),
        SizedBox(height: SoteriaSpacing.md),
        Container(
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SoteriaErrorWidget(
            message: 'Unable to connect to foundation services.',
            onRetry: () {},
          ),
        ),

        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('ANIMATION PREVIEW'),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.primary(
          label: 'Re-run Splash Experience',
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
      ],
    );
  }
}
