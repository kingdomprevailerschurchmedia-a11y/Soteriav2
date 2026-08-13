import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../providers/matchmaking_providers.dart';
import '../domain/models/matchmaking_status.dart';

class MatchmakingScreen extends ConsumerWidget {
  const MatchmakingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(matchmakingSessionProvider);
    final timer = ref.watch(queueTimerProvider).value ?? 0;

    ref.listen(matchmakingSessionProvider, (prev, next) {
      final session = next.value;
      if (session?.status == MatchmakingStatus.matchFound) {
        context.pushReplacement('/app/match-found');
      } else if (session?.status == MatchmakingStatus.cancelled) {
        context.pop();
      }
    });

    return SoteriaPage(
      child: Scaffold(
        backgroundColor: SoteriaColors.background,
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(gradient: SoteriaColors.backgroundGradient),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const _SearchingAnimation(),
                SizedBox(height: SoteriaSpacing.xxl),
                Text(
                  'SEARCHING FOR RIVAL',
                  style: context.headlineSmall.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: SoteriaSpacing.sm),
                Text(
                  _formatTimer(timer),
                  style: context.displayMedium.copyWith(
                    color: SoteriaColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SoteriaSpacing.md),
                Text(
                  'Estimated wait: < 1m',
                  style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.all(SoteriaSpacing.xl),
                  child: SoteriaButton.secondary(
                    label: 'CANCEL SEARCH',
                    onPressed: () => ref.read(matchmakingControllerProvider.notifier).cancelQueue(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimer(int seconds) {
    final mins = (seconds / 60).floor();
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

class _SearchingAnimation extends StatefulWidget {
  const _SearchingAnimation();

  @override
  State<_SearchingAnimation> createState() => _SearchingAnimationState();
}

class _SearchingAnimationState extends State<_SearchingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Transform.scale(
                scale: 1.0 + (_controller.value + (i * 0.33)) % 1.0 * 1.5,
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: SoteriaColors.primary.withValues(
                        alpha: (1.0 - (_controller.value + (i * 0.33)) % 1.0) * 0.5,
                      ),
                      width: 2,
                    ),
                  ),
                ),
              ),
            Container(
              width: 100.w,
              height: 100.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: SoteriaColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: SoteriaColors.primary,
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 48),
            ),
          ],
        );
      },
    );
  }
}
