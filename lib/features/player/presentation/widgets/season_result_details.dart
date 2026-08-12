import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';
import '../../domain/models/season_result.dart';
import 'rank_badge.dart';

class SeasonResultDetailsView extends StatelessWidget {
  final SeasonResult result;

  const SeasonResultDetailsView({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: SoteriaColors.backgroundTopLeft,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(SoteriaSpacing.lg),
              children: [
                SoteriaScaleIn(
                  duration: SoteriaAnimations.slow,
                  child: Center(
                    child: RankBadge(
                      rankName: result.finalTier,
                      tierId: result.finalTier,
                      isLarge: true,
                    ),
                  ),
                ),
                SizedBox(height: SoteriaSpacing.lg),
                Center(
                  child: Text(
                    result.seasonName,
                    style: SoteriaTypography.headlineSmall.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'SEASON ${result.seasonNumber} ARCHIVE',
                    style: SoteriaTypography.labelSmall.copyWith(
                      color: SoteriaColors.gold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(height: SoteriaSpacing.xl),
                _buildMetricGrid(context),
                SizedBox(height: SoteriaSpacing.xl),
                _buildSectionHeader(context, 'Competitive Path'),
                _buildDetailRow(context, 'Initial Rank', result.previousTier),
                _buildDetailRow(context, 'Final Rank', result.finalTier),
                _buildDetailRow(
                  context,
                  'Rank Progress',
                  '${result.rankChange > 0 ? '+' : ''}${result.rankChange} RP',
                  highlighted: result.rankChange != 0,
                  highlightColor: result.rankChange > 0
                      ? SoteriaColors.success
                      : SoteriaColors.error,
                ),
                _buildDetailRow(
                  context,
                  'Season End',
                  _formatDate(result.completedAt),
                ),

                if (result.statistics != null &&
                    result.statistics!.isNotEmpty) ...[
                  SizedBox(height: SoteriaSpacing.xl),
                  _buildSectionHeader(context, 'Performance Data'),
                  ...result.statistics!.entries.map(
                    (e) => _buildDetailRow(
                      context,
                      _formatStatKey(e.key),
                      e.value.toString(),
                    ),
                  ),
                ],
                SizedBox(height: SoteriaSpacing.xxl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildLargeMetric(
            context,
            'Final Position',
            result.finalTier.toLowerCase() == 'unranked'
                ? 'N/A'
                : '#${result.finalPosition}',
            isGold: true,
          ),
        ),
        SizedBox(width: SoteriaSpacing.md),
        Expanded(
          child: _buildLargeMetric(
            context,
            'Total Points',
            '${result.finalRankPoints} RP',
          ),
        ),
      ],
    );
  }

  Widget _buildLargeMetric(
    BuildContext context,
    String label,
    String value, {
    bool isGold = false,
  }) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: SoteriaTypography.headlineSmall.copyWith(
              color: isGold ? SoteriaColors.gold : SoteriaColors.textPrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: SoteriaTypography.labelSmall.copyWith(
              color: SoteriaColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: SoteriaTypography.labelSmall.copyWith(
              color: SoteriaColors.textSecondary.withValues(alpha: 0.5),
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: Colors.white10),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool highlighted = false,
    Color? highlightColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: SoteriaTypography.bodyLarge.copyWith(
              color: SoteriaColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: SoteriaTypography.titleMedium.copyWith(
              color: highlighted
                  ? (highlightColor ?? SoteriaColors.gold)
                  : SoteriaColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatStatKey(String key) {
    final words = key
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .split(RegExp(r'[\s_]'));
    return words
        .map(
          (w) => w.isNotEmpty
              ? w[0].toUpperCase() + w.substring(1).toLowerCase()
              : '',
        )
        .join(' ')
        .trim();
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
