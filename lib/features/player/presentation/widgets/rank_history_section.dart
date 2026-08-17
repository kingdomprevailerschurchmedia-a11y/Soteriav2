import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../domain/models/rank_change.dart';
import '../providers/rank_providers.dart';
import 'rank_badge.dart';

class RankHistorySection extends ConsumerWidget {
  const RankHistorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(rankHistoryProvider);

    return historyAsync.when(
      data: (history) {
        if (history.isEmpty) {
          return Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1638).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.person_search_rounded,
                    color: Colors.white10,
                    size: 48.r,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'No competitive matches played yet.',
                    textAlign: TextAlign.center,
                    style: context.bodySmall.copyWith(color: Colors.white70),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Play matches to build your history!',
                    textAlign: TextAlign.center,
                    style: context.bodySmall.copyWith(color: Colors.white30, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
          );
        }
        return SoteriaCard(
          padding: EdgeInsets.zero,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: history.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withValues(alpha: 0.05),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final change = history[index];
              return _RankHistoryTile(change: change);
            },
          ),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Container(
        padding: EdgeInsets.all(24.r),
        child: Center(child: Text('Error loading history')),
      ),
    );
  }
}

class _RankHistoryTile extends StatelessWidget {
  final RankChange change;

  const _RankHistoryTile({required this.change});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.md,
        vertical: SoteriaSpacing.sm,
      ),
      leading: RankBadge(
        rankName: change.newRank,
        tierId: change.newRank.split(' ')[0].toLowerCase(),
      ),
      title: Text(change.newRank, style: context.titleSmall),
      subtitle: Text(_formatDate(change.createdAt), style: context.bodySmall),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${change.changeAmount > 0 ? '+' : ''}${change.changeAmount} RP',
            style: context.labelMedium.copyWith(
              color: change.changeAmount >= 0
                  ? SoteriaColors.success
                  : SoteriaColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${change.newRankPoints} TOTAL',
            style: context.labelSmall.copyWith(color: SoteriaColors.muted),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
