import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';
import '../providers/quiz_providers.dart';
import '../../domain/models/score_result.dart';

class ScoreGainAnimation extends ConsumerStatefulWidget {
  const ScoreGainAnimation({super.key});

  @override
  ConsumerState<ScoreGainAnimation> createState() => _ScoreGainAnimationState();
}

class _ScoreGainAnimationState extends ConsumerState<ScoreGainAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  ScoreResult? _lastResult;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: SoteriaAnimations.slow,
    );

    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20),
    ]).animate(_controller);

    _offset = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: SoteriaAnimations.emphasize,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prefersReducedMotion = MediaQuery.of(context).prefersReducedMotion;

    ref.listen(quizControllerProvider.select((s) => s.lastScoreResult),
        (previous, next) {
      if (next != null && next != _lastResult && next.totalScore > 0) {
        _lastResult = next;
        _controller.forward(from: 0.0);
      }
    });

    final result = ref.read(quizControllerProvider).lastScoreResult;
    if (result == null || result.totalScore == 0) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_controller.isDismissed && _lastResult != null) {
          return const SizedBox.shrink();
        }

        return Semantics(
          label: result.totalScore > 0
              ? '${result.totalScore} points and ${result.xpEarned} XP earned'
              : '',
          child: FadeTransition(
            opacity: _opacity,
            child: prefersReducedMotion
                ? child!
                : SlideTransition(
                    position: _offset,
                    child: child,
                  ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (result.totalScore > 0)
            Text(
              '+${result.totalScore}',
              style: context.headlineMedium.copyWith(
                color: SoteriaColors.gold,
                fontWeight: FontWeight.w900,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          if (result.xpEarned > 0)
            Text(
              '+${result.xpEarned} XP',
              style: context.titleMedium.copyWith(
                color: SoteriaColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
