import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';

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
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
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
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: offset, end: 0.0),
      duration: duration,
      curve: Curves.easeOutCubic,
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
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: begin, end: 1.0),
      duration: duration,
      curve: Curves.easeOutBack,
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
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: offset, end: 0.0),
      duration: duration,
      curve: Curves.easeOutCubic,
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
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: beginBlur, end: 0.0),
      duration: duration,
      curve: Curves.easeOut,
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
