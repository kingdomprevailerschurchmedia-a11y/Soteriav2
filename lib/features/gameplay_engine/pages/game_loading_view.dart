import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';

class GameLoadingView extends StatelessWidget {
  const GameLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: SoteriaColors.primary),
          SizedBox(height: SoteriaSpacing.xl),
          Text(
            'PREPARING SESSION',
            style: context.labelLarge.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 4.0,
            ),
          ),
          SizedBox(height: SoteriaSpacing.sm),
          Text(
            'CALIBRATING ENGINE...',
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
          ),
        ],
      ),
    );
  }
}
