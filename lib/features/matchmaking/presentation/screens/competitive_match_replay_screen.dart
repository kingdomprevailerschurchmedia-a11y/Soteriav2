import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/components/soteria_state_views.dart';
import '../../../../shared/widgets/soteria_page.dart';
import 'package:soteria/features/matchmaking/presentation/providers/match_result_providers.dart';
import 'package:soteria/features/matchmaking/domain/models/competitive_match_replay.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';

class CompetitiveMatchReplayScreen extends ConsumerStatefulWidget {
  final String matchId;

  const CompetitiveMatchReplayScreen({super.key, required this.matchId});

  @override
  ConsumerState<CompetitiveMatchReplayScreen> createState() => _CompetitiveMatchReplayScreenState();
}

class _CompetitiveMatchReplayScreenState extends ConsumerState<CompetitiveMatchReplayScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final replayAsync = ref.watch(matchReplayProvider(widget.matchId));

    return SoteriaPage(
      child: Scaffold(
        backgroundColor: SoteriaColors.background,
        appBar: AppBar(
          title: const Text('MATCH REPLAY'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: replayAsync.when(
          data: (replay) {
            if (replay == null) {
              return const SoteriaEmptyView(
                title: 'NO DATA',
                message: 'Match details not found.',
                icon: Icons.history_rounded,
              );
            }
            
            final question = replay.questions[_currentIndex];
            final playerAnswer = replay.result.playerPerformance.answers.firstWhere(
              (a) => a.questionId == question.id,
              orElse: () => _emptyAnswer(question.id),
            );

            return Column(
              children: [
                _ReplayHeader(replay: replay),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(SoteriaSpacing.lg),
                    child: Column(
                      children: [
                        _QuestionIndicator(
                          current: _currentIndex + 1,
                          total: replay.questions.length,
                        ),
                        SizedBox(height: SoteriaSpacing.md),
                        _QuestionReplayCard(question: question),
                        SizedBox(height: SoteriaSpacing.lg),
                        _AnswersList(
                          question: question,
                          playerAnswer: playerAnswer,
                        ),
                        SizedBox(height: SoteriaSpacing.xl),
                        _QuestionStats(answer: playerAnswer),
                      ],
                    ),
                  ),
                ),
                _NavigationControls(
                  currentIndex: _currentIndex,
                  total: replay.questions.length,
                  onPrev: () => setState(() => _currentIndex--),
                  onNext: () => setState(() => _currentIndex++),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, __) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  AnswerResult _emptyAnswer(String qId) => AnswerResult(
    submissionId: 'none',
    questionId: qId,
    decision: AnswerDecision.skipped,
    correctOptionIds: [],
    timestamp: DateTime.now(),
  );
}

class _ReplayHeader extends StatelessWidget {
  final CompetitiveMatchReplay replay;
  const _ReplayHeader({required this.replay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl, vertical: SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CompactPlayer(label: 'YOU', score: replay.result.playerScore),
          Column(
            children: [
              Text(
                'VS',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted, fontStyle: FontStyle.italic),
              ),
              Text(
                '${replay.result.playerScore} - ${replay.result.opponentScore}',
                style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          _CompactPlayer(label: 'RIVAL', score: replay.result.opponentScore),
        ],
      ),
    );
  }
}

class _CompactPlayer extends StatelessWidget {
  final String label;
  final int score;
  const _CompactPlayer({required this.label, required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: context.labelSmall.copyWith(color: SoteriaColors.muted, fontSize: 8)),
        Text(score.toString(), style: context.titleMedium.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _QuestionIndicator extends StatelessWidget {
  final int current;
  final int total;
  const _QuestionIndicator({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= total; i++)
          Container(
            width: 24.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              color: i == current ? SoteriaColors.primary : Colors.white10,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }
}

class _QuestionReplayCard extends StatelessWidget {
  final Question question;
  const _QuestionReplayCard({required this.question});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                question.category.toUpperCase(),
                style: context.labelSmall.copyWith(color: SoteriaColors.gold, fontWeight: FontWeight.bold),
              ),
              _DifficultyBadge(difficulty: question.difficulty),
            ],
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            question.text,
            style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _DifficultyBadge extends StatelessWidget {
  final QuestionDifficulty difficulty;
  const _DifficultyBadge({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        difficulty.name.toUpperCase(),
        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white70),
      ),
    );
  }
}

class _AnswersList extends StatelessWidget {
  final Question question;
  final AnswerResult playerAnswer;

  const _AnswersList({required this.question, required this.playerAnswer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: question.options.map((option) {
        final isCorrect = question.correctAnswers.contains(option.id);
        final isSelected = playerAnswer.submissionId == option.id; // Corrected: usage of submissionId for selectedId for demo

        Color color = Colors.white.withValues(alpha: 0.05);
        Color borderColor = Colors.white.withValues(alpha: 0.05);
        IconData? icon;

        if (isCorrect) {
          color = SoteriaColors.success.withValues(alpha: 0.1);
          borderColor = SoteriaColors.success.withValues(alpha: 0.3);
          icon = Icons.check_circle_rounded;
        } else if (isSelected) {
          color = SoteriaColors.error.withValues(alpha: 0.1);
          borderColor = SoteriaColors.error.withValues(alpha: 0.3);
          icon = Icons.cancel_rounded;
        }

        return Container(
          margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
          padding: EdgeInsets.all(SoteriaSpacing.md),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option.text,
                  style: context.bodyMedium.copyWith(
                    fontWeight: isSelected || isCorrect ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (icon != null) Icon(icon, color: isCorrect ? SoteriaColors.success : SoteriaColors.error, size: 20),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _QuestionStats extends StatelessWidget {
  final AnswerResult answer;
  const _QuestionStats({required this.answer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _StatItem(
          label: 'RESPONSE TIME',
          value: '${(answer.metadata['responseTime'] ?? 0) / 1000}s',
          icon: Icons.timer_outlined,
        ),
        _StatItem(
          label: 'POINTS',
          value: '+${answer.xpEarned}',
          icon: Icons.bolt_rounded,
          color: SoteriaColors.primary,
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  const _StatItem({required this.label, required this.value, required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color ?? SoteriaColors.muted, size: 20),
        SizedBox(height: 4.h),
        Text(value, style: context.titleMedium.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: context.labelSmall.copyWith(color: SoteriaColors.muted, fontSize: 8)),
      ],
    );
  }
}

class _NavigationControls extends StatelessWidget {
  final int currentIndex;
  final int total;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _NavigationControls({
    required this.currentIndex,
    required this.total,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: SoteriaColors.surface.withValues(alpha: 0.8),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Row(
        children: [
          Expanded(
            child: SoteriaButton.secondary(
              label: 'PREVIOUS',
              onPressed: currentIndex > 0 ? onPrev : null,
            ),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: SoteriaButton.primary(
              label: currentIndex < total - 1 ? 'NEXT' : 'FINISH REPLAY',
              onPressed: currentIndex < total - 1 ? onNext : () => context.pop(),
            ),
          ),
        ],
      ),
    );
  }
}
