import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/animations/soteria_animations.dart';
import 'package:soteria/core/widgets/typography/soteria_text.dart';
import 'package:soteria/core/widgets/cards/soteria_card.dart';

class AnimationsPreviewPage extends StatelessWidget {
  const AnimationsPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        SoteriaFadeIn(
          duration: const Duration(seconds: 1),
          child: const SoteriaCard(
            child: SoteriaText.body('Fade In Animation'),
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaSlideUp(
          duration: const Duration(seconds: 1),
          child: const SoteriaCard(
            child: SoteriaText.body('Slide Up Animation'),
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaScaleIn(
          duration: const Duration(seconds: 1),
          child: const SoteriaCard(
            child: SoteriaText.body('Scale In Animation'),
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaSlideLeft(
          duration: const Duration(seconds: 1),
          child: const SoteriaCard(
            child: SoteriaText.body('Slide Left Animation'),
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaBlurTransition(
          duration: const Duration(seconds: 1),
          child: const SoteriaCard(
            child: SoteriaText.body('Blur Transition Animation'),
          ),
        ),
      ],
    );
  }
}
