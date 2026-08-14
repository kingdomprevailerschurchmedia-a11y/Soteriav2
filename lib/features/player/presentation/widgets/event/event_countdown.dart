import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

final countdownTimerProvider = StreamProvider.autoDispose<DateTime>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
});

class EventCountdown extends ConsumerWidget {
  final DateTime targetDate;
  final String label;

  const EventCountdown({super.key, required this.targetDate, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(countdownTimerProvider).value ?? DateTime.now();
    final difference = targetDate.difference(now);

    if (difference.isNegative) {
      return Text(
        'EXPIRED',
        style: context.labelSmall.copyWith(color: SoteriaColors.error),
      );
    }

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    final timeString = '${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: context.labelSmall.copyWith(color: SoteriaColors.muted),
        ),
        Text(
          timeString,
          style: context.titleMedium.copyWith(
            color: SoteriaColors.gold,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
