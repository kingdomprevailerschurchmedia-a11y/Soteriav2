import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';

class _SoteriaAnimation extends StatefulWidget {
  const _SoteriaAnimation({
    required this.child,
    required this.delay,
    required this.duration,
    required this.curve,
    required this.tween,
    required this.builder,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final Tween<double> tween;
  final Widget Function(BuildContext, double, Widget?) builder;

  @override
  State<_SoteriaAnimation> createState() => _SoteriaAnimationState();
}

class _SoteriaAnimationState extends State<_SoteriaAnimation> {
  bool _start = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.delay == Duration.zero) {
      _start = true;
    } else {
      _timer = Timer(widget.delay, () {
        if (mounted) setState(() => _start = true);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return widget.child;

    if (!_start) {
      return Opacity(opacity: 0.0, child: widget.child);
    }

    return TweenAnimationBuilder<double>(
      tween: widget.tween,
      duration: widget.duration,
      curve: widget.curve,
      builder: widget.builder,
      child: widget.child,
    );
  }
}

class SoteriaFadeIn extends StatelessWidget {
  const SoteriaFadeIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = SoteriaAnimations.normal,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return _SoteriaAnimation(
      delay: delay,
      duration: duration,
      curve: Curves.easeOut,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: child,
    );
  }
}

class SoteriaSlideUp extends StatelessWidget {
  const SoteriaSlideUp({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = SoteriaAnimations.normal,
    this.offset = 30.0,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return _SoteriaAnimation(
      delay: delay,
      duration: duration,
      curve: Curves.easeOutCubic,
      tween: Tween(begin: offset, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Opacity(
            opacity: ((offset - value) / offset).clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class SoteriaSlideDown extends StatelessWidget {
  const SoteriaSlideDown({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = SoteriaAnimations.normal,
    this.offset = -30.0,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return _SoteriaAnimation(
      delay: delay,
      duration: duration,
      curve: Curves.easeOutCubic,
      tween: Tween(begin: offset, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Opacity(
            opacity: ((offset.abs() - value.abs()) / offset.abs()).clamp(
              0.0,
              1.0,
            ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class SoteriaScaleIn extends StatelessWidget {
  const SoteriaScaleIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = SoteriaAnimations.normal,
    this.begin = 0.8,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double begin;

  @override
  Widget build(BuildContext context) {
    return _SoteriaAnimation(
      delay: delay,
      duration: duration,
      curve: Curves.easeOutBack,
      tween: Tween(begin: begin, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: ((value - begin) / (1.0 - begin)).clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class SoteriaSlideLeft extends StatelessWidget {
  const SoteriaSlideLeft({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = SoteriaAnimations.normal,
    this.offset = 30.0,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return _SoteriaAnimation(
      delay: delay,
      duration: duration,
      curve: Curves.easeOutCubic,
      tween: Tween(begin: offset, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value, 0),
          child: Opacity(
            opacity: ((offset - value) / offset).clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class SoteriaBlurTransition extends StatelessWidget {
  const SoteriaBlurTransition({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = SoteriaAnimations.normal,
    this.beginBlur = 10.0,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double beginBlur;

  @override
  Widget build(BuildContext context) {
    return _SoteriaAnimation(
      delay: delay,
      duration: duration,
      curve: Curves.easeOut,
      tween: Tween(begin: beginBlur, end: 0.0),
      builder: (context, value, child) {
        return ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: value, sigmaY: value),
          child: Opacity(
            opacity: ((beginBlur - value) / beginBlur).clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
