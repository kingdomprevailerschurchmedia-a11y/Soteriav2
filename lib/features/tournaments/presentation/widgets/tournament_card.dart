import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_badge.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/tournaments/domain/models/tournament.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_status.dart';

class TournamentCard extends StatelessWidget {
  final Tournament tournament;
  final VoidCallback onTap;

  const TournamentCard({
    super.key,
    required this.tournament,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          'Tournament: ${tournament.name}, Prize Pool: \$${tournament.prizePool}',
      button: true,
      onTapHint: 'View tournament details',
      child: SoteriaFadeIn(
        child: SoteriaScaleIn(
          child: SoteriaCard(
            onTap: onTap,
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBanner(),
                Padding(
                  padding: EdgeInsets.all(SoteriaSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleRow(context),
                      SizedBox(height: SoteriaSpacing.sm),
                      _buildInfoRow(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            tournament.bannerUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: SoteriaColors.elevatedSurface,
              child: const Icon(Icons.image_not_supported),
            ),
          ),
        ),
        Positioned(
          top: SoteriaSpacing.sm,
          left: SoteriaSpacing.sm,
          child: _StatusBadge(status: tournament.status),
        ),
      ],
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Text(
      tournament.name,
      style: context.titleLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildInfoRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _InfoItem(
          icon: Icons.emoji_events_rounded,
          label: '\$${tournament.prizePool.toStringAsFixed(0)}',
          color: SoteriaColors.gold,
        ),
        _InfoItem(
          icon: Icons.people_rounded,
          label: '${tournament.registeredPlayers}/${tournament.maxPlayers}',
          color: SoteriaColors.textSecondary,
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final TournamentStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case TournamentStatus.live:
        return const SoteriaBadge(
          label: 'Live',
          variant: SoteriaBadgeVariant.error,
          icon: Icons.circle,
        );
      case TournamentStatus.registrationOpen:
        return const SoteriaBadge(
          label: 'Open',
          variant: SoteriaBadgeVariant.success,
        );
      case TournamentStatus.upcoming:
        return const SoteriaBadge(
          label: 'Upcoming',
          variant: SoteriaBadgeVariant.info,
        );
      case TournamentStatus.completed:
        return const SoteriaBadge(
          label: 'Completed',
          variant: SoteriaBadgeVariant.muted,
        );
      default:
        return SoteriaBadge(
          label: status.name.toUpperCase(),
          variant: SoteriaBadgeVariant.muted,
        );
    }
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: color),
        SizedBox(width: 4.w),
        Text(label, style: context.labelMedium.copyWith(color: color)),
      ],
    );
  }
}
