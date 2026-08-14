import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import '../../domain/models/live_event.dart';
import 'event_countdown_widget.dart';

class LiveEventCard extends StatelessWidget {
  final LiveEvent event;
  final VoidCallback? onTap;

  const LiveEventCard({
    super.key,
    required this.event,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = event.status == LiveEventStatus.active;
    final isUpcoming = event.status == LiveEventStatus.upcoming;

    return SoteriaCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (event.imageUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  event.imageUrl!,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 120,
                    color: SoteriaColors.primary.withValues(alpha: 0.2),
                    child: const Icon(Icons.bolt_rounded, size: 48, color: SoteriaColors.primary),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(SoteriaSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatusBadge(status: event.status),
                      if (isActive)
                        EventCountdownWidget(
                          targetDate: event.endAt,
                          prefix: '',
                        )
                      else if (isUpcoming)
                        EventCountdownWidget(
                          targetDate: event.startAt,
                          prefix: 'Starts in',
                        ),
                    ],
                  ),
                  SizedBox(height: SoteriaSpacing.sm),
                  Text(
                    event.name,
                    style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: SoteriaSpacing.xs),
                  Text(
                    event.description,
                    style: context.bodySmall.copyWith(color: Colors.white70),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (event.rewardConfig.isNotEmpty) ...[
                    SizedBox(height: SoteriaSpacing.md),
                    _RewardPreview(rewardConfig: event.rewardConfig),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final LiveEventStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case LiveEventStatus.active:
        color = SoteriaColors.success;
        break;
      case LiveEventStatus.upcoming:
        color = SoteriaColors.secondary;
        break;
      case LiveEventStatus.ending:
        color = SoteriaColors.warning;
        break;
      default:
        color = SoteriaColors.muted;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: context.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _RewardPreview extends StatelessWidget {
  final Map<String, dynamic> rewardConfig;
  const _RewardPreview({required this.rewardConfig});

  @override
  Widget build(BuildContext context) {
    // Simple preview logic
    final xpBoost = rewardConfig['xp_multiplier'];
    final coins = rewardConfig['coins'];

    return Row(
      children: [
        if (xpBoost != null)
          _RewardItem(
            icon: Icons.bolt_rounded,
            label: '${xpBoost}x XP',
            color: SoteriaColors.xpColor,
          ),
        if (coins != null) ...[
          if (xpBoost != null) SizedBox(width: SoteriaSpacing.md),
          _RewardItem(
            icon: Icons.monetization_on_rounded,
            label: '$coins',
            color: SoteriaColors.gold,
          ),
        ],
      ],
    );
  }
}

class _RewardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _RewardItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: context.labelMedium.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
