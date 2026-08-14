import 'dart:async';
import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class EventCountdownWidget extends StatefulWidget {
  final DateTime targetDate;
  final String prefix;
  final TextStyle? style;

  const EventCountdownWidget({
    super.key,
    required this.targetDate,
    this.prefix = '',
    this.style,
  });

  @override
  State<EventCountdownWidget> createState() => _EventCountdownWidgetState();
}

class _EventCountdownWidgetState extends State<EventCountdownWidget> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _calculateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _calculateRemaining());
    });
  }

  void _calculateRemaining() {
    _remaining = widget.targetDate.difference(DateTime.now());
    if (_remaining.isNegative) {
      _remaining = Duration.zero;
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_remaining == Duration.zero) {
      return Text(
        'ENDED',
        style: widget.style ??
            context.labelMedium.copyWith(color: SoteriaColors.error),
      );
    }

    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    String timeStr;
    if (days > 0) {
      timeStr = '${days}d ${hours}h';
    } else if (hours > 0) {
      timeStr = '${hours}h ${minutes}m';
    } else {
      timeStr = '${minutes}m ${seconds}s';
    }

    return Text(
      '${widget.prefix} $timeStr'.trim(),
      style: widget.style ??
          context.labelMedium.copyWith(
            color: _remaining < const Duration(hours: 1)
                ? SoteriaColors.error
                : SoteriaColors.success,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
