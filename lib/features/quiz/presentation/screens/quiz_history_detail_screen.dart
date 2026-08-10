import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../domain/models/quiz_result.dart';
import '../widgets/results/results_components.dart';

class QuizHistoryDetailScreen extends StatelessWidget {
  const QuizHistoryDetailScreen({super.key, required this.result});
  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    return SafeGradientScaffold(
      appBar: AppBar(
        title: Text(
          'HISTORY DETAIL',
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          SliverToBoxAdapter(child: ResultsHero(result: result)),
          SliverToBoxAdapter(child: ScoreSummary(result: result)),
          
          if (result.powerUpsUsed.isNotEmpty)
            SliverPadding(
              padding: EdgeInsets.all(SoteriaSpacing.lg),
              sliver: SliverToBoxAdapter(
                child: _PowerUpSummary(powerUps: result.powerUpsUsed),
              ),
            ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            sliver: SliverToBoxAdapter(
              child: Text(
                'QUESTION BREAKDOWN',
                style: context.labelMedium.copyWith(
                  color: Colors.white70,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => QuestionResultCard(
                  result: result.questionResults[index],
                ),
                childCount: result.questionResults.length,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 40.h)),
        ],
      ),
    );
  }
}

class _PowerUpSummary extends StatelessWidget {
  const _PowerUpSummary({required this.powerUps});
  final List<dynamic> powerUps; // PowerUpType

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'POWER-UPS USED',
          style: context.labelMedium.copyWith(
            color: Colors.white70,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        Wrap(
          spacing: 8.w,
          children: powerUps.map((p) => Chip(
            label: Text(p.toString().split('.').last.toUpperCase()),
            backgroundColor: SoteriaColors.primary.withValues(alpha: 0.1),
            labelStyle: context.labelSmall.copyWith(color: SoteriaColors.primary),
            padding: EdgeInsets.zero,
          )).toList(),
        ),
      ],
    );
  }
}
