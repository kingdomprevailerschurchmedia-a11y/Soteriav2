import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/shared/widgets/soteria_page.dart';
import '../providers/auth_landing_notifier.dart';
import '../widgets/email_login_dialog.dart';

class AuthLandingScreen extends ConsumerWidget {
  const AuthLandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SoteriaPage(
      showBackground: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: const _AuthLandingContent(),
      ),
    );
  }
}

class _AuthLandingContent extends ConsumerWidget {
  const _AuthLandingContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authLandingProvider);
    final notifier = ref.read(authLandingProvider.notifier);

    ref.listen(authLandingProvider.select((s) => s.error), (previous, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next), backgroundColor: SoteriaColors.error),
        );
      }
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 16.h),

          // Welcome Illustration
          Expanded(
            flex: 4,
            child: Center(
              child: Image.asset(
                'assets/images/welcome_illustration.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Welcome Text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome to',
                style: context.displaySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 32.sp,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'Soteria',
                style: context.displayLarge.copyWith(
                  color: SoteriaColors.gold,
                  fontWeight: FontWeight.w900,
                  fontSize: 48.sp,
                  letterSpacing: -1.0,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Rise through knowledge and\ncompete with the best.',
                style: context.bodyLarge.copyWith(
                  color: Colors.white.withValues(alpha: 0.5),
                  height: 1.3,
                  fontSize: 15.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          SizedBox(height: 32.h),

          // Action Buttons
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Continue with Google
              _PrimaryButton(
                label: 'Continue with Google',
                onTap: () => notifier.signInWithGoogle(),
                isLoading: state.isLoading,
              ),

              SizedBox(height: 12.h),

              // Create Account
              _SecondaryButton(
                label: 'Create Account',
                onTap: state.isLoading
                    ? null
                    : () => ref
                        .read(navigationServiceProvider)
                        .push('${SoteriaRoutes.auth}/register'),
              ),

              SizedBox(height: 24.h),

              // Login with Email
              TextButton(
                onPressed: state.isLoading
                    ? null
                    : () => EmailLoginDialog.show(context),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Login with Email',
                  style: context.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(flex: 1),

          // Footer Links
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegalLink(label: 'Terms', onTap: () {}),
                const _LegalDot(),
                _LegalLink(label: 'Privacy', onTap: () {}),
                const _LegalDot(),
                _LegalLink(label: 'Guidelines', onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );

  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLoading;

  const _PrimaryButton({
    required this.label,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isLoading ? 0.6 : 1.0,
        child: Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: SoteriaColors.gold,
            boxShadow: [
              BoxShadow(
                color: SoteriaColors.gold.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: const CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/icons8-google-48.png',
                        height: 24.h,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        label,
                        style: context.titleMedium.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _SecondaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isDisabled ? 0.4 : 1.0,
        child: Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: Colors.white.withValues(alpha: 0.04),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: context.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LegalLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _LegalLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: SoteriaColors.gold,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          decorationColor: SoteriaColors.gold.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _LegalDot extends StatelessWidget {
  const _LegalDot();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Text(
        '•',
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.3),
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
