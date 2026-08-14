import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';

class EventResultScreen extends ConsumerWidget {
  final String eventId;
  final int score;

  const EventResultScreen({
    super.key,
    required this.eventId,
    required this.score,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeGradientScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SoteriaScaleIn(
              child: const Icon(
                Icons.emoji_events_rounded,
                color: SoteriaColors.gold,
                size: 80,
              ),
            ),
            SizedBox(height: SoteriaSpacing.xl),
            Text(
              'EVENT COMPLETE',
              style: context.displaySmall.copyWith(
                fontWeight: FontWeight.w900,
                color: SoteriaColors.gold,
                letterSpacing: 4,
              ),
            ),
            SizedBox(height: SoteriaSpacing.lg),
            Text(
              'YOUR SCORE',
              style: context.labelSmall.copyWith(color: SoteriaColors.muted),
            ),
            Text(
              score.toString(),
              style: context.displayLarge.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
              child: Column(
                children: [
                  SoteriaButton.primary(
                    label: 'VIEW LEADERBOARD',
                    onPressed: () =>
                        context.push('/app/events/leaderboard/$eventId'),
                  ),
                  SizedBox(height: SoteriaSpacing.md),
                  SoteriaButton.secondary(
                    label: 'RETURN TO EVENTS',
                    onPressed: () => context.go('/app/events'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
