import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../shared/widgets/soteria_page.dart';
import 'package:soteria/features/matchmaking/presentation/providers/match_result_providers.dart';
import 'package:soteria/features/matchmaking/domain/services/competitive_insights_service.dart';
import 'package:soteria/features/analytics/presentation/charts/soteria_line_chart.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';

class CompetitiveInsightsScreen extends ConsumerWidget {
  const CompetitiveInsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightsAsync = ref.watch(competitiveInsightsProvider);

    return SoteriaPage(
      child: Scaffold(
        backgroundColor: SoteriaColors.background,
        appBar: AppBar(
          title: const Text('COMPETITIVE INSIGHTS'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: insightsAsync.when(
          data: (insights) => _buildContent(context, insights),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CompetitiveInsights insights) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RecentFormSection(form: insights.recentForm),
          SizedBox(height: SoteriaSpacing.xl),
          _TrendSection(
            title: 'ACCURACY TREND',
            trend: insights.accuracyTrend,
            unit: '%',
          ),
          SizedBox(height: SoteriaSpacing.xl),
          _TrendSection(
            title: 'SCORING TREND',
            trend: insights.scoreTrend,
            color: SoteriaColors.gold,
          ),
          SizedBox(height: SoteriaSpacing.xl),
          _CategoryPerformanceSection(
            strongest: insights.strongestCategory,
            breakdown: insights.categoryPerformance,
          ),
          SizedBox(height: SoteriaSpacing.xxxl),
        ],
      ),
    );
  }
}

class _RecentFormSection extends StatelessWidget {
  final List<CompetitiveOutcome> form;
  const _RecentFormSection({required this.form});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RECENT FORM',
          style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 2),
        ),
        SizedBox(height: SoteriaSpacing.md),
        Row(
          children: form.map((outcome) {
            Color color;
            String label;
            switch (outcome) {
              case CompetitiveOutcome.win: color = SoteriaColors.success; label = 'W'; break;
              case CompetitiveOutcome.loss: color = SoteriaColors.error; label = 'L'; break;
              case CompetitiveOutcome.draw: color = SoteriaColors.gold; label = 'D'; break;
              default: color = SoteriaColors.muted; label = '-';
            }
            return Container(
              width: 40.w,
              height: 40.w,
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _TrendSection extends StatelessWidget {
  final String title;
  final dynamic trend;
  final String unit;
  final Color? color;

  const _TrendSection({required this.title, required this.trend, this.unit = '', this.color});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
              Text(
                'AVG: ${trend.averageValue.toInt()}$unit',
                style: context.bodySmall.copyWith(color: color ?? SoteriaColors.primary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.lg),
          SizedBox(
            height: 120.h,
            child: SoteriaLineChart(trend: trend, color: color),
          ),
        ],
      ),
    );
  }
}

class _CategoryPerformanceSection extends StatelessWidget {
  final String strongest;
  final Map<String, double> breakdown;

  const _CategoryPerformanceSection({required this.strongest, required this.breakdown});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CATEGORY PERFORMANCE',
          style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 2),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaCard(
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome_rounded, color: SoteriaColors.gold),
                  SizedBox(width: SoteriaSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Strongest Area', style: context.labelSmall.copyWith(color: SoteriaColors.muted)),
                      Text(strongest.toUpperCase(), style: context.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const Divider(height: 32, color: Colors.white10),
              ...breakdown.entries.map((e) => _CategoryRow(name: e.key, accuracy: e.value)),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final String name;
  final double accuracy;
  const _CategoryRow({required this.name, required this.accuracy});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: context.bodyMedium),
              Text('${accuracy.toInt()}%', style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 4.h),
          LinearProgressIndicator(
            value: accuracy / 100,
            backgroundColor: Colors.white10,
            color: SoteriaColors.primary,
            minHeight: 4,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ),
    );
  }
}
