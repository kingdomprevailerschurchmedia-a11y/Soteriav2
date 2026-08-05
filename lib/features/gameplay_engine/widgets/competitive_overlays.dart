import 'package:flutter/material.dart';
import '../../../core/design_system/colors/soteria_colors.dart';
import '../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../core/design_system/typography/soteria_typography.dart';
import '../../../core/design_system/components/soteria_button.dart';

class ConnectionLostOverlay extends StatelessWidget {
  final VoidCallback onRetry;
  const ConnectionLostOverlay({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.9),
      padding: EdgeInsets.all(SoteriaSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            color: SoteriaColors.error,
            size: 84,
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Text(
            'CONNECTION INTERRUPTED',
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.w900,
              color: SoteriaColors.error,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            'Pro Mode requires a stable internet connection to ensure competitive fairness. Gameplay has been paused.',
            style: context.bodyMedium.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SoteriaSpacing.xxxl),
          SoteriaButton.primary(
            label: 'RECONNECTING...',
            onPressed: null, // Loading state
            isLoading: true,
          ),
          SizedBox(height: SoteriaSpacing.md),
          SoteriaButton.ghost(label: 'TRY AGAIN MANUALLY', onPressed: onRetry),
        ],
      ),
    );
  }
}

class ProPausedView extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onQuit;

  const ProPausedView({
    super.key,
    required this.onResume,
    required this.onQuit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SoteriaColors.background.withValues(alpha: 0.9),
      padding: EdgeInsets.all(SoteriaSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'CHALLENGE PAUSED',
            style: context.displaySmall.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          SoteriaButton.primary(label: 'RESUME CHALLENGE', onPressed: onResume),
          SizedBox(height: SoteriaSpacing.md),
          SoteriaButton(
            label: 'ABANDON SESSION',
            onPressed: onQuit,
            variant: SoteriaButtonVariant.danger,
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Text(
            'Note: Abandoning a Pro session results in a loss of the entry fee.',
            style: context.labelSmall.copyWith(color: SoteriaColors.muted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
