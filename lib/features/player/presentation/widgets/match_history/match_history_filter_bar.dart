import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/player/presentation/providers/match_history_providers.dart';
import 'package:soteria/features/player/presentation/providers/season_providers.dart';

class MatchHistoryFilterBar extends ConsumerWidget {
  const MatchHistoryFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(matchHistoryFiltersProvider);
    final seasonsAsync = ref.watch(allSeasonsProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Row(
        children: [
          _buildSeasonFilter(context, ref, seasonsAsync, filters),
          SizedBox(width: SoteriaSpacing.sm),
          _buildModeFilter(context, ref, filters),
          SizedBox(width: SoteriaSpacing.sm),
          _buildOutcomeFilter(context, ref, filters),
        ],
      ),
    );
  }

  Widget _buildSeasonFilter(
    BuildContext context,
    WidgetRef ref,
    AsyncValue seasonsAsync,
    MatchHistoryFilters filters,
  ) {
    return _FilterMenuButton(
      label: filters.seasonId == null
          ? 'All Seasons'
          : 'Season ${filters.seasonId!.split("_").last}',
      onSelected: (value) {
        if (value == 'all') {
          ref
              .read(matchHistoryFiltersProvider.notifier)
              .update((s) => s.copyWith(clearSeason: true));
        } else {
          ref
              .read(matchHistoryFiltersProvider.notifier)
              .update((s) => s.copyWith(seasonId: value));
        }
      },
      items: [
        const PopupMenuItem(value: 'all', child: Text('All Seasons')),
        ...?seasonsAsync.value?.map(
          (s) => PopupMenuItem(value: s.seasonId, child: Text(s.name)),
        ),
      ],
      isSelected: filters.seasonId != null,
    );
  }

  Widget _buildModeFilter(
    BuildContext context,
    WidgetRef ref,
    MatchHistoryFilters filters,
  ) {
    return _FilterMenuButton(
      label: filters.mode ?? 'All Modes',
      onSelected: (value) {
        if (value == 'all') {
          ref
              .read(matchHistoryFiltersProvider.notifier)
              .update((s) => s.copyWith(clearMode: true));
        } else {
          ref
              .read(matchHistoryFiltersProvider.notifier)
              .update((s) => s.copyWith(mode: value));
        }
      },
      items: const [
        PopupMenuItem(value: 'all', child: Text('All Modes')),
        PopupMenuItem(value: 'tournament', child: Text('Tournament')),
        PopupMenuItem(value: 'versus', child: Text('Versus')),
        PopupMenuItem(value: 'pro', child: Text('Pro Mode')),
      ],
      isSelected: filters.mode != null,
    );
  }

  Widget _buildOutcomeFilter(
    BuildContext context,
    WidgetRef ref,
    MatchHistoryFilters filters,
  ) {
    return _FilterMenuButton(
      label: filters.outcome == null
          ? 'All Results'
          : filters.outcome!.name.toUpperCase(),
      onSelected: (value) {
        if (value == 'all') {
          ref
              .read(matchHistoryFiltersProvider.notifier)
              .update((s) => s.copyWith(clearOutcome: true));
        } else {
          ref
              .read(matchHistoryFiltersProvider.notifier)
              .update((s) => s.copyWith(outcome: value as CompetitiveOutcome));
        }
      },
      items: [
        const PopupMenuItem(value: 'all', child: Text('All Results')),
        ...CompetitiveOutcome.values.map(
          (o) => PopupMenuItem(value: o, child: Text(o.name.toUpperCase())),
        ),
      ],
      isSelected: filters.outcome != null,
    );
  }
}

class _FilterMenuButton extends StatelessWidget {
  final String label;
  final List<PopupMenuEntry<dynamic>> items;
  final Function(dynamic) onSelected;
  final bool isSelected;

  const _FilterMenuButton({
    required this.label,
    required this.items,
    required this.onSelected,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<dynamic>(
      onSelected: onSelected,
      itemBuilder: (context) => items,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected
              ? SoteriaColors.primary
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(SoteriaRadius.md),
          border: Border.all(
            color: isSelected ? SoteriaColors.primary : Colors.white10,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.toUpperCase(),
              style: context.labelSmall.copyWith(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 14.sp,
              color: isSelected ? Colors.white : Colors.white38,
            ),
          ],
        ),
      ),
    );
  }
}
