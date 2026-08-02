import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_state.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_status.dart';
import 'package:soteria/features/gameplay_engine/timer/widgets/adaptive_timer_display.dart';

class TimerPreviewGallery extends StatelessWidget {
  const TimerPreviewGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            context,
            'Timer Statuses',
            Wrap(
              spacing: 32,
              runSpacing: 32,
              children: [
                _TimerPreviewItem(
                  label: 'Running',
                  state: const TimerState(
                    remaining: Duration(seconds: 12),
                    total: Duration(seconds: 15),
                    status: TimerStatus.running,
                  ),
                ),
                _TimerPreviewItem(
                  label: 'Warning',
                  state: const TimerState(
                    remaining: Duration(seconds: 4),
                    total: Duration(seconds: 15),
                    status: TimerStatus.warning,
                  ),
                ),
                _TimerPreviewItem(
                  label: 'Critical',
                  state: const TimerState(
                    remaining: Duration(milliseconds: 1500),
                    total: Duration(seconds: 15),
                    status: TimerStatus.critical,
                  ),
                ),
                _TimerPreviewItem(
                  label: 'Paused',
                  state: const TimerState(
                    remaining: Duration(seconds: 8),
                    total: Duration(seconds: 15),
                    status: TimerStatus.paused,
                  ),
                ),
                _TimerPreviewItem(
                  label: 'Expired',
                  state: const TimerState(
                    remaining: Duration.zero,
                    total: Duration(seconds: 15),
                    status: TimerStatus.expired,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.labelLarge.copyWith(color: SoteriaColors.gold),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        child,
        SizedBox(height: SoteriaSpacing.xxl),
      ],
    );
  }
}

class _TimerPreviewItem extends StatelessWidget {
  const _TimerPreviewItem({required this.label, required this.state});
  final String label;
  final TimerState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdaptiveTimerDisplay(state: state, size: 80),
        SizedBox(height: SoteriaSpacing.sm),
        Text(
          label,
          style: context.bodySmall.copyWith(color: SoteriaColors.muted),
        ),
      ],
    );
  }
}
