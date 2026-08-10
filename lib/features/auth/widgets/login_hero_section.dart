import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';

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
          children: [
            // Arc / Glow Effect
            Transform.translate(
              offset: Offset(0, -150.h),
              child: Container(
                width: 400.w,
                height: 400.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
                    width: 2,
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

            // Profile Icon Container
            Container(
              margin: EdgeInsets.only(top: 40.h),
              width: 110.w,
              height: 110.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF7C4DFF).withValues(alpha: 0.6),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 60.w,
                  color: const Color(0xFFD4AF37),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40.h),
        Text(
          greeting,
          style: context.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 36.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          'Continue your journey. Compete. Learn. Rise.',
          style: context.bodyMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
