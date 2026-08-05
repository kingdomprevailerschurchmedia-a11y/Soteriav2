import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/tournaments/presentation/providers/tournament_countdown_provider.dart';

class TournamentCountdownWidget extends ConsumerWidget {
  final DateTime targetDate;
  final String label;

  const TournamentCountdownWidget({
    super.key,
    required this.targetDate,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countdown = ref.watch(tournamentCountdownProvider(targetDate));

    return countdown.when(
      data: (duration) => _buildCountdown(context, duration),
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildCountdown(BuildContext context, Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final mins = duration.inMinutes % 60;
    final secs = duration.inSeconds % 60;

    return Semantics(
      label:
          'Tournament countdown: $days days, $hours hours, $mins minutes, $secs seconds',
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: SoteriaSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TimeUnit(value: days, unit: 'Days'),
              _TimeDivider(),
              _TimeUnit(value: hours, unit: 'Hrs'),
              _TimeDivider(),
              _TimeUnit(value: mins, unit: 'Mins'),
              _TimeDivider(),
              _TimeUnit(value: secs, unit: 'Secs'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeUnit extends StatelessWidget {
  final int value;
  final String unit;

  const _TimeUnit({required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: context.headlineMedium.copyWith(
            color: SoteriaColors.textPrimary,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(unit, style: context.bodySmall.copyWith(fontSize: 10.sp)),
      ],
    );
  }
}

class _TimeDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md),
      child: Text(
        ':',
        style: context.headlineMedium.copyWith(color: SoteriaColors.muted),
      ),
    );
  }
}
