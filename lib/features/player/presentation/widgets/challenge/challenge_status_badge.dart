import 'package:flutter/material.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../domain/models/competitive_challenge.dart';

class ChallengeStatusBadge extends StatelessWidget {
  final ChallengeStatus status;

  const ChallengeStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case ChallengeStatus.pending:
        color = SoteriaColors.warning;
        break;
      case ChallengeStatus.accepted:
      case ChallengeStatus.active:
        color = SoteriaColors.success;
        break;
      case ChallengeStatus.declined:
      case ChallengeStatus.cancelled:
        color = SoteriaColors.error;
        break;
      case ChallengeStatus.expired:
        color = SoteriaColors.muted;
        break;
      case ChallengeStatus.completed:
        color = SoteriaColors.primary;
        break;
      default:
        color = SoteriaColors.muted;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
