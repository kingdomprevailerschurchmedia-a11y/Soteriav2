import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/shared/widgets/soteria_divider.dart';
import '../providers/login_notifier.dart';
import '../widgets/login_hero_section.dart';
import '../widgets/login_form.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/welcomescreen_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
            child: Column(
              children: [
                LoginHeroSection(userName: state.userName),
                const LoginForm(),
                SizedBox(height: 8.h),
                const SoteriaDivider(text: 'OR'),
                SizedBox(height: 8.h),
                Column(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: context.bodyMedium.copyWith(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    GestureDetector(
                      onTap: state.isLoading
                          ? null
                          : () => ref
                                .read(navigationServiceProvider)
                                .push('${SoteriaRoutes.auth}/register'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CREATE ONE',
                            style: context.titleMedium.copyWith(
                              color: const Color(0xFF7C4DFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: const Color(0xFF7C4DFF),
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
