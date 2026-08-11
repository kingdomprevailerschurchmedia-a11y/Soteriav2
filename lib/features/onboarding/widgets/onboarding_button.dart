import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';

enum OnboardingButtonVariant { next, skip }

class SoteriaOnboardingButton extends StatefulWidget {
  const SoteriaOnboardingButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = OnboardingButtonVariant.next,
  });

  final String label;
  final VoidCallback onPressed;
  final OnboardingButtonVariant variant;

  @override
  State<SoteriaOnboardingButton> createState() =>
      _SoteriaOnboardingButtonState();
}

class _SoteriaOnboardingButtonState extends State<SoteriaOnboardingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: SoteriaAnimations.fastest,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.variant == OnboardingButtonVariant.skip) {
      return _buildSkipButton(context);
    }
    return _buildNextButton(context);
  }

  Widget _buildSkipButton(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.label,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label.toUpperCase(),
                style: context.labelLarge.copyWith(
                  color: SoteriaColors.secondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                height: 1.5.h,
                width: 24.w,
                color: SoteriaColors.secondary.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.label,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: widget.onPressed,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer Glow
              Container(
                width: 140.w.clamp(120.0, 160.0),
                height: 52.h.clamp(48.0, 60.0),
                decoration: BoxDecoration(
                  borderRadius: SoteriaRadius.brFull,
                  boxShadow: [
                    BoxShadow(
                      color: SoteriaColors.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              // Button Body
              ClipRRect(
                borderRadius: SoteriaRadius.brFull,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 140.w.clamp(120.0, 160.0),
                    height: 52.h.clamp(48.0, 60.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: SoteriaRadius.brFull,
                      border: Border.all(
                        color: SoteriaColors.secondary.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.label.toUpperCase(),
                          style: context.labelLarge.copyWith(
                            color: SoteriaColors.textPrimary,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: SoteriaColors.textPrimary,
                          size: 20.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
