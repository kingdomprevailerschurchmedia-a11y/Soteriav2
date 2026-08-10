import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/radius/soteria_radius.dart';
import '../../../domain/models/quiz_enums.dart';
import '../../providers/history_providers.dart';

class HistoryFilterBar extends ConsumerWidget {
  const HistoryFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(historyFiltersProvider);
    final currentSort = ref.watch(historySortProvider);

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          child: Row(
            children: [
              _FilterChip(
                label: 'All Modes',
                isSelected: filters.mode == null,
                onSelected: (_) => ref
                    .read(historyFiltersProvider.notifier)
                    .update((s) => s.copyWith(clearMode: true)),
              ),
              ...GameMode.values.map(
                (mode) => _FilterChip(
                  label: mode.name.toUpperCase(),
                  isSelected: filters.mode == mode,
                  onSelected: (_) => ref
                      .read(historyFiltersProvider.notifier)
                      .update((s) => s.copyWith(mode: mode)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          child: Row(
            children: [
              Expanded(child: _SearchField()),
              SizedBox(width: SoteriaSpacing.md),
              _SortButton(currentSort: currentSort),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: FilterChip(
        label: Text(
          label,
          style: context.labelSmall.copyWith(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        selected: isSelected,
        onSelected: onSelected,
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        selectedColor: SoteriaColors.primary,
        checkmarkColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SoteriaRadius.md),
          side: BorderSide(
            color: isSelected ? SoteriaColors.primary : Colors.white10,
          ),
        ),
      ),
    );
  }
}

class _SearchField extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(SoteriaRadius.md),
        border: Border.all(color: Colors.white10),
      ),
      child: TextField(
        onChanged: (value) =>
            ref.read(historySearchProvider.notifier).state = value,
        style: context.bodyMedium.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search history...',
          hintStyle: context.bodyMedium.copyWith(color: Colors.white38),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.white38,
            size: 20.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        ),
      ),
    );
  }
}

class _SortButton extends ConsumerWidget {
  const _SortButton({required this.currentSort});
  final HistorySort currentSort;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 44.h,
      width: 44.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(SoteriaRadius.md),
        border: Border.all(color: Colors.white10),
      ),
      child: IconButton(
        icon: Icon(
          Icons.sort_rounded,
          color: SoteriaColors.secondary,
          size: 20.sp,
        ),
        onPressed: () => _showSortSheet(context, ref),
      ),
    );
  }

  void _showSortSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: SoteriaColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SoteriaRadius.xl),
        ),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: SoteriaSpacing.lg),
          Text(
            'SORT BY',
            style: context.labelLarge.copyWith(
              color: Colors.white70,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          ...HistorySort.values.map(
            (sort) => ListTile(
              title: Text(
                _getSortLabel(sort),
                style: context.bodyLarge.copyWith(
                  color: currentSort == sort
                      ? SoteriaColors.primary
                      : Colors.white,
                  fontWeight: currentSort == sort
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              trailing: currentSort == sort
                  ? Icon(Icons.check_rounded, color: SoteriaColors.primary)
                  : null,
              onTap: () {
                ref.read(historySortProvider.notifier).state = sort;
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: SoteriaSpacing.xl),
        ],
      ),
    );
  }

  String _getSortLabel(HistorySort sort) {
    switch (sort) {
      case HistorySort.newest:
        return 'Newest First';
      case HistorySort.oldest:
        return 'Oldest First';
      case HistorySort.highestScore:
        return 'Highest Score';
      case HistorySort.highestAccuracy:
        return 'Highest Accuracy';
      case HistorySort.highestXp:
        return 'Highest XP';
      case HistorySort.bestStreak:
        return 'Best Streak';
    }
  }
}
