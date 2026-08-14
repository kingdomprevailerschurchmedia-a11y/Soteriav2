import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_badge.dart';
import '../providers/season_providers.dart';
import 'season_countdown_widget.dart';
import '../../domain/models/competitive_season.dart';
import '../../domain/models/season_countdown.dart';

class SeasonHeader extends ConsumerWidget {
  const SeasonHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seasonAsync = ref.watch(currentSeasonProvider);
    final status = ref.watch(derivedSeasonStatusProvider);
    final countdownAsync = ref.watch(seasonCountdownProvider);

    return seasonAsync.when(
      data: (season) {
        if (season == null) return const SizedBox.shrink();

        return SoteriaCard(
          onTap: () => context.push('/app/season'),
          padding: EdgeInsets.all(SoteriaSpacing.sm),
          margin: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md),
          hasGlow: status == SeasonStatus.ending,
          glowColor: status == SeasonStatus.ending
              ? SoteriaColors.error
              : SoteriaColors.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SEASON ${season.seasonNumber ?? ''}',
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.muted,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w900,
                            fontSize: 10.sp,
                          ),
                        ),
                        Text(
                          season.name.toUpperCase(),
                          style: context.titleMedium.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: SoteriaSpacing.md),
                  _buildStatusBadge(status),
                ],
              ),
              SizedBox(height: SoteriaSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status == SeasonStatus.upcoming
                            ? 'STARTS IN'
                            : 'ENDS IN',
                        style: context.labelSmall.copyWith(
                          color: SoteriaColors.muted,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      countdownAsync.when(
                        data: (countdown) => SeasonCountdownWidget(
                          countdown: countdown,
                          isEndingSoon: status == SeasonStatus.ending,
                        ),
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  if (season.description != null)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: SoteriaSpacing.md),
                        child: Text(
                          season.description!,
                          style: context.bodySmall.copyWith(
                            color: SoteriaColors.textSecondary,
                            fontStyle: FontStyle.italic,
                            fontSize: 10.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildStatusBadge(SeasonStatus status) {
    switch (status) {
      case SeasonStatus.active:
        return const SoteriaBadge(
          label: 'ACTIVE',
          variant: SoteriaBadgeVariant.success,
        );
      case SeasonStatus.ending:
        return const SoteriaBadge(
          label: 'ENDING SOON',
          variant: SoteriaBadgeVariant.error,
        );
      case SeasonStatus.upcoming:
        return const SoteriaBadge(
          label: 'UPCOMING',
          variant: SoteriaBadgeVariant.info,
        );
      case SeasonStatus.completed:
        return const SoteriaBadge(
          label: 'COMPLETED',
          variant: SoteriaBadgeVariant.muted,
        );
      case SeasonStatus.archived:
        return const SoteriaBadge(
          label: 'ARCHIVED',
          variant: SoteriaBadgeVariant.muted,
        );
    }
  }
}
