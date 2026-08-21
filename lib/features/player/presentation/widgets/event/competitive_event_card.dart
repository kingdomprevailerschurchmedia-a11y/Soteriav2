import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import '../../../domain/models/live_event.dart';
import 'event_status_badge.dart';
import 'event_countdown.dart';

class CompetitiveEventCard extends StatelessWidget {
  final LiveEvent event;
  final VoidCallback onTap;

  const CompetitiveEventCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final xp = event.rewardConfiguration['xp'] as int? ?? 0;
    final coins = event.rewardConfiguration['coins'] as int? ?? 0;

    return Container(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: SoteriaColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SoteriaColors.border),
        boxShadow: [
          if (event.status == LiveEventStatus.live || event.status == LiveEventStatus.ending)
            BoxShadow(
              color: SoteriaColors.primary.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(SoteriaSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EventStatusBadge(status: event.status),
                  if (event.status == LiveEventStatus.live || event.status == LiveEventStatus.ending)
                    EventCountdown(
                      targetDate: event.endAt,
                      label: 'Ends in',
                    )
                  else if (event.status == LiveEventStatus.upcoming)
                    EventCountdown(
                      targetDate: event.startAt,
                      label: 'Starts in',
                    ),
                ],
              ),
              SizedBox(height: SoteriaSpacing.md),
              Text(
                event.title.toUpperCase(),
                style: context.headlineSmall.copyWith(
                  color: SoteriaColors.textPrimary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: SoteriaSpacing.xs),
              Text(
                event.description,
                style: context.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: SoteriaSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RewardPreview(xp: xp, coins: coins),
                  _buildCTA(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCTA(BuildContext context) {
    String label;
    Color color = SoteriaColors.primary;

    switch (event.status) {
      case LiveEventStatus.live:
      case LiveEventStatus.ending:
        label = 'JOIN';
        break;
      case LiveEventStatus.upcoming:
        label = 'VIEW';
        break;
      case LiveEventStatus.ended:
        label = 'RESULTS';
        color = SoteriaColors.muted;
        break;
      case LiveEventStatus.cancelled:
        label = 'CANCELLED';
        color = SoteriaColors.error;
        break;
      case LiveEventStatus.locked:
        label = 'LOCKED';
        color = SoteriaColors.muted;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.lg,
        vertical: SoteriaSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: context.labelLarge.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _RewardPreview extends StatelessWidget {
  final int xp;
  final int coins;

  const _RewardPreview({required this.xp, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (xp > 0) ...[
          const Icon(Icons.bolt, color: SoteriaColors.xpColor, size: 14),
          const SizedBox(width: 4),
          Text(
            '+$xp',
            style: context.labelMedium.copyWith(color: SoteriaColors.xpColor),
          ),
          SizedBox(width: SoteriaSpacing.sm),
        ],
        if (coins > 0) ...[
          const Icon(Icons.monetization_on, color: SoteriaColors.gold, size: 14),
          const SizedBox(width: 4),
          Text(
            '+$coins',
            style: context.labelMedium.copyWith(color: SoteriaColors.gold),
          ),
        ],
      ],
    );
  }
}
