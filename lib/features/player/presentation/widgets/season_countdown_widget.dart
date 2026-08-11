import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../domain/models/season_countdown.dart';

class SeasonCountdownWidget extends StatelessWidget {
  final SeasonCountdown countdown;
  final bool isEndingSoon;

  const SeasonCountdownWidget({
    super.key,
    required this.countdown,
    this.isEndingSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    if (countdown.status == CountdownStatus.ended) {
      return Text(
        'SEASON ENDED',
        style: context.labelLarge.copyWith(
          color: SoteriaColors.muted,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      );
    }

    if (countdown.status == CountdownStatus.unavailable) {
      return const SizedBox.shrink();
    }

    final color = isEndingSoon ? SoteriaColors.error : SoteriaColors.gold;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (countdown.days > 0) ...[
          _TimeUnit(value: countdown.days, label: 'D', color: color),
          _Separator(color: color),
        ],
        _TimeUnit(value: countdown.hours, label: 'H', color: color),
        _Separator(color: color),
        _TimeUnit(value: countdown.minutes, label: 'M', color: color),
        _Separator(color: color),
        _TimeUnit(value: countdown.seconds, label: 'S', color: color),
      ],
    );
  }
}

class _TimeUnit extends StatelessWidget {
  final int value;
  final String label;
  final Color color;

  const _TimeUnit({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: context.titleMedium.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
            fontFamily: 'RobotoMono', // Use monospaced for numbers if available
          ),
        ),
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: color.withValues(alpha: 0.6),
            fontSize: 8.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _Separator extends StatelessWidget {
  final Color color;
  const _Separator({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        ':',
        style: context.titleMedium.copyWith(
          color: color.withValues(alpha: 0.5),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
