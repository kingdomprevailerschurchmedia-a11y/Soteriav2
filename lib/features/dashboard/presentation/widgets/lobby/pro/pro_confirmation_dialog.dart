import 'package:flutter/material.dart';
import '../../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../../core/design_system/components/soteria_button.dart';
import '../../../../../../core/widgets/glass_surface.dart';

class ProEntryConfirmationDialog extends StatelessWidget {
  final int fee;
  final VoidCallback onConfirm;

  const ProEntryConfirmationDialog({
    super.key,
    required this.fee,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassSurface(
        padding: EdgeInsets.all(SoteriaSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock_clock_rounded,
              color: SoteriaColors.gold,
              size: 48,
            ),
            SizedBox(height: SoteriaSpacing.xl),
            Text(
              'INITIATE CHALLENGE',
              style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              'You are about to spend $fee coins to enter this competitive session. No refunds will be issued once the session begins.',
              style: context.bodyMedium.copyWith(
                color: SoteriaColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            SoteriaButton.primary(
              label: 'CONFIRM ENTRY',
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
            ),
            SizedBox(height: SoteriaSpacing.md),
            SoteriaButton.ghost(
              label: 'CANCEL',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
