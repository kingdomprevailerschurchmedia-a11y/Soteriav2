import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import '../../../domain/models/live_event.dart';

class EventStatusBadge extends StatelessWidget {
  final LiveEventStatus status;

  const EventStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case LiveEventStatus.live:
        color = SoteriaColors.success;
        label = 'LIVE NOW';
        break;
      case LiveEventStatus.upcoming:
        color = SoteriaColors.warning;
        label = 'UPCOMING';
        break;
      case LiveEventStatus.ending:
        color = SoteriaColors.warning;
        label = 'ENDING SOON';
        break;
      case LiveEventStatus.ended:
        color = SoteriaColors.muted;
        label = 'ENDED';
        break;
      case LiveEventStatus.cancelled:
        color = SoteriaColors.error;
        label = 'CANCELLED';
        break;
      case LiveEventStatus.locked:
        color = SoteriaColors.muted;
        label = 'LOCKED';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: context.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
