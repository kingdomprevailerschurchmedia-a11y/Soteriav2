import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../auth/providers/auth_providers.dart';
import '../providers/match_lifecycle_providers.dart';

class VersusLiveScoreboard extends ConsumerWidget {
  const VersusLiveScoreboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchAsync = ref.watch(activeMatchProvider);
    final currentUserId = ref.watch(authRepositoryProvider).currentUserId;

    return matchAsync.when(
      data: (match) {
        if (match == null) return const SizedBox.shrink();

        final isPlayerA = match.playerAId == currentUserId;
        final myScore = isPlayerA ? match.playerAScore : match.playerBScore;
        final opponentScore = isPlayerA ? match.playerBScore : match.playerAScore;
        final myProgress = isPlayerA ? match.playerAProgress : match.playerBProgress;
        final opponentProgress = isPlayerA ? match.playerBProgress : match.playerAProgress;
        final totalQuestions = match.configuration['questionCount'] ?? 10;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg, vertical: SoteriaSpacing.md),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
          ),
          child: Row(
            children: [
              _PlayerMiniScore(
                label: 'YOU',
                score: myScore,
                progress: (myProgress + 1) / totalQuestions,
                isMe: true,
              ),
              const Spacer(),
              _VersusBadge(),
              const Spacer(),
              _PlayerMiniScore(
                label: 'RIVAL',
                score: opponentScore,
                progress: (opponentProgress + 1) / totalQuestions,
                isMe: false,
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _PlayerMiniScore extends StatelessWidget {
  final String label;
  final int score;
  final double progress;
  final bool isMe;

  const _PlayerMiniScore({
    required this.label,
    required this.score,
    required this.progress,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isMe) ...[
              Text(
                score.toString(),
                style: context.titleMedium.copyWith(fontWeight: FontWeight.w900, color: SoteriaColors.gold),
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              label,
              style: context.labelSmall.copyWith(color: SoteriaColors.muted, fontSize: 8),
            ),
            if (isMe) ...[
              SizedBox(width: 8.w),
              Text(
                score.toString(),
                style: context.titleMedium.copyWith(fontWeight: FontWeight.w900, color: SoteriaColors.gold),
              ),
            ],
          ],
        ),
        SizedBox(height: 4.h),
        Container(
          width: 100.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: isMe ? SoteriaColors.primary : SoteriaColors.error,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VersusBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        'VS',
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          color: Colors.white60,
        ),
      ),
    );
  }
}
