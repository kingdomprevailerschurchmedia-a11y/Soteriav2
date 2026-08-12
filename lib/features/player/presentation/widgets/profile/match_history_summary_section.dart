import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/player/presentation/providers/match_history_providers.dart';
import 'package:soteria/features/player/presentation/widgets/match_history/competitive_match_history_card.dart';

class MatchHistorySummarySection extends ConsumerWidget {
  final VoidCallback onViewAll;

  const MatchHistorySummarySection({super.key, required this.onViewAll});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesAsync = ref.watch(currentUserMatchHistoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'RECENT MATCHES',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                letterSpacing: 1.5,
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              child: Text(
                'VIEW ALL',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        matchesAsync.when(
          data: (matches) {
            if (matches.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
                child: Text(
                  'No matches played yet.',
                  style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                ),
              );
            }
            return Column(
              children: matches
                  .take(3)
                  .map((match) => CompetitiveMatchHistoryCard(match: match))
                  .toList(),
            );
          },
          loading: () => _buildLoading(),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          height: 80.h,
          margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
