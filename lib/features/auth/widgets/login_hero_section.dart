import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class LoginHeroSection extends StatelessWidget {
  const LoginHeroSection({super.key, this.userName});

  final String? userName;

  @override
  Widget build(BuildContext context) {
    final greeting = userName != null
        ? 'Welcome back, $userName'
        : 'Welcome Back';

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Large Top Arc Glow (matching the design)
            Positioned(
              top: -300.h,
              child: Container(
                width: 500.w,
                height: 500.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF7C4DFF).withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF7C4DFF).withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // App Logo Container
            Container(
              margin: EdgeInsets.only(top: 20.h),
              width: 140.w,
              height: 140.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF7C4DFF).withValues(alpha: 0.4),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C4DFF).withValues(alpha: 0.2),
                    blurRadius: 25,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logo_icon.png',
                  width: 80.w,
                  height: 80.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Text(
          greeting,
          style: context.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 32.sp,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Text(
          'Continue your journey. Compete. Learn. Rise.',
          style: context.bodyMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 15.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}
