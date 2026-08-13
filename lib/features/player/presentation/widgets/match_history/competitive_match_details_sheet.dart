import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/player/domain/models/competitive_match.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/player/presentation/widgets/rank_badge.dart';
import 'package:soteria/features/player/presentation/screens/public_competitive_profile_screen.dart';

import 'package:go_router/go_router.dart';

class CompetitiveMatchDetailsSheet extends StatelessWidget {
  final CompetitiveMatch match;

  const CompetitiveMatchDetailsSheet({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final result = match.result;
    final quiz = match.quizResult;
    final rankChange = match.rankChange;

    return Container(
      decoration: BoxDecoration(
        color: SoteriaColors.backgroundTopLeft,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: SoteriaSpacing.md),
          _buildHandle(),
          SizedBox(height: SoteriaSpacing.lg),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, result),
                  SizedBox(height: SoteriaSpacing.xl),
                  if (quiz != null) ...[
                    _buildPerformanceGrid(context, quiz),
                    SizedBox(height: SoteriaSpacing.xl),
                  ],
                  if (rankChange != null) ...[
                    _buildRankImpact(context, rankChange),
                    SizedBox(height: SoteriaSpacing.xl),
                  ],
                  _buildMatchInfo(context, result),
                  if (result.opponentId != null) ...[
                    SizedBox(height: SoteriaSpacing.xl),
                    _buildOpponentButton(context, result.opponentId!),
                  ],
                  SizedBox(height: SoteriaSpacing.md),
                  _buildReplayButton(context, result.resultId),
                  SizedBox(height: SoteriaSpacing.xxl),
                  _buildBackButton(context),
                  SizedBox(height: SoteriaSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 48.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CompetitiveResult result) {
    final isWin = result.outcome == CompetitiveOutcome.win;
    final color = isWin ? SoteriaColors.success : SoteriaColors.error;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.mode.toUpperCase(),
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              isWin ? 'VICTORY' : 'DEFEAT',
              style: context.headlineMedium.copyWith(
                color: color,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        _buildOutcomeIcon(isWin),
      ],
    );
  }

  Widget _buildOutcomeIcon(bool isWin) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: (isWin ? SoteriaColors.success : SoteriaColors.error).withValues(
          alpha: 0.1,
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isWin ? Icons.emoji_events_rounded : Icons.close_rounded,
        color: isWin ? SoteriaColors.success : SoteriaColors.error,
        size: 32.sp,
      ),
    );
  }

  Widget _buildPerformanceGrid(BuildContext context, dynamic quiz) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PERFORMANCE',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          mainAxisSpacing: SoteriaSpacing.md,
          crossAxisSpacing: SoteriaSpacing.md,
          children: [
            _buildStatItem(
              context,
              'SCORE',
              quiz.finalScore.toString(),
              Icons.bolt_rounded,
              SoteriaColors.primary,
            ),
            _buildStatItem(
              context,
              'ACCURACY',
              '${(quiz.accuracy * 100).toInt()}%',
              Icons.track_changes_rounded,
              SoteriaColors.warning,
            ),
            _buildStatItem(
              context,
              'CORRECT',
              '${quiz.correctAnswers}/${quiz.totalQuestions}',
              Icons.check_circle_rounded,
              SoteriaColors.success,
            ),
            _buildStatItem(
              context,
              'TIME',
              '${quiz.completionTime.inMinutes}m ${quiz.completionTime.inSeconds % 60}s',
              Icons.timer_rounded,
              SoteriaColors.secondary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(width: SoteriaSpacing.sm),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  fontSize: 10.sp,
                ),
              ),
              Text(
                value,
                style: context.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRankImpact(BuildContext context, dynamic rankChange) {
    final isPositive = rankChange.changeAmount > 0;

    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SoteriaColors.primary.withValues(alpha: 0.1),
            SoteriaColors.secondary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: SoteriaColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RANK IMPACT',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SoteriaSpacing.sm,
                  vertical: SoteriaSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color:
                      (isPositive ? SoteriaColors.success : SoteriaColors.error)
                          .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${isPositive ? '+' : ''}${rankChange.changeAmount} RP',
                  style: context.labelMedium.copyWith(
                    color: isPositive
                        ? SoteriaColors.success
                        : SoteriaColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRankStep(context, rankChange.oldRank, 'BEFORE'),
              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white24,
                size: 24.sp,
              ),
              _buildRankStep(context, rankChange.newRank, 'AFTER'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRankStep(BuildContext context, String rank, String label) {
    // Assuming rank is something like "Gold I"
    final tierId = rank.split(' ').first.toLowerCase();

    return Column(
      children: [
        RankBadge(rankName: rank, tierId: tierId, isLarge: true),
        SizedBox(height: SoteriaSpacing.xs),
        Text(
          rank,
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 8.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildMatchInfo(BuildContext context, CompetitiveResult result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MATCH DETAILS',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        _buildInfoRow(
          context,
          'MATCH ID',
          result.resultId.toUpperCase().substring(0, 12),
        ),
        _buildInfoRow(context, 'DATE', _formatDate(result.completedAt)),
        _buildInfoRow(context, 'SEASON', result.seasonId.toUpperCase()),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
          ),
          Text(
            value,
            style: context.bodySmall.copyWith(
              color: Colors.white70,
              fontFamily: 'Monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpponentButton(BuildContext context, String opponentId) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.pop(context);
          GoRouter.of(context).push('/app/profile/public/$opponentId');
        },
        icon: const Icon(Icons.person_search_rounded),
        label: const Text('VIEW OPPONENT PROFILE'),
        style: OutlinedButton.styleFrom(
          foregroundColor: SoteriaColors.secondary,
          side: const BorderSide(color: SoteriaColors.secondary),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }

  Widget _buildReplayButton(BuildContext context, String matchId) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
          GoRouter.of(context).push('/app/versus/replay/$matchId');
        },
        icon: const Icon(Icons.play_circle_fill_rounded),
        label: const Text('WATCH MATCH REPLAY'),
        style: ElevatedButton.styleFrom(
          backgroundColor: SoteriaColors.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.05),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: const Text('CLOSE'),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
