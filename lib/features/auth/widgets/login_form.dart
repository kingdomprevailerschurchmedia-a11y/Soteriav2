import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/components/soteria_text_field.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import '../providers/login_notifier.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    final notifier = ref.read(loginProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel(context, 'EMAIL ADDRESS'),
        SizedBox(height: 12.h),
        _buildTextField(
          context: context,
          hintText: 'name@example.com',
          prefixIcon: Icons.mail_outline_rounded,
          onChanged: notifier.updateEmail,
          keyboardType: TextInputType.emailAddress,
          enabled: !state.isLoading,
        ),
        SizedBox(height: 24.h),
        _buildLabel(context, 'PASSWORD'),
        SizedBox(height: 12.h),
        _buildTextField(
          context: context,
          hintText: 'Enter your password',
          prefixIcon: Icons.lock_outline_rounded,
          obscureText: true,
          onChanged: notifier.updatePassword,
          enabled: !state.isLoading,
          isPassword: true,
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: state.isLoading ? null : notifier.toggleRememberMe,
              child: Row(
                children: [
                  Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: SoteriaColors.secondary.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                      color:
                          state.rememberMe
                              ? SoteriaColors.secondary
                              : Colors.transparent,
                    ),
                    child:
                        state.rememberMe
                            ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                            : null,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Remember Me',
                    style: context.bodyMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap:
                  state.isLoading
                      ? null
                      : () => ref
                          .read(navigationServiceProvider)
                          .push(
                            '${SoteriaRoutes.auth}/verify/passwordRecovery',
                          ),
              child: Row(
                children: [
                  Text(
                    'Forgot Password?',
                    style: context.labelSmall.copyWith(
                      color: const Color(0xFFD4AF37),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: const Color(0xFFD4AF37),
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (state.error != null) ...[
          SizedBox(height: SoteriaSpacing.md),
          Text(
            state.error!,
            style: context.bodySmall.copyWith(color: SoteriaColors.error),
            textAlign: TextAlign.center,
          ),
        ],
        SizedBox(height: 40.h),
        GestureDetector(
          onTap: state.isLoading ? null : () => notifier.login(),
          child: Container(
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: const LinearGradient(
                colors: [Color(0xFF5E2BFF), Color(0xFF4A10FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5E2BFF).withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child:
                  state.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                        'SIGN IN',
                        style: context.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: context.labelSmall.copyWith(
        color: Colors.white.withValues(alpha: 0.4),
        letterSpacing: 1.2,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String hintText,
    required IconData prefixIcon,
    required ValueChanged<String>? onChanged,
    bool obscureText = false,
    bool enabled = true,
    TextInputType? keyboardType,
    bool isPassword = false,
  }) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFF0D0B1E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: TextField(
        onChanged: onChanged,
        obscureText: obscureText,
        enabled: enabled,
        keyboardType: keyboardType,
        style: context.bodyLarge.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.bodyLarge.copyWith(
            color: Colors.white.withValues(alpha: 0.2),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: SoteriaColors.secondary,
            size: 24.sp,
          ),
          suffixIcon:
              isPassword
                  ? Icon(
                    Icons.visibility_off_rounded,
                    color: SoteriaColors.secondary,
                    size: 24.sp,
                  )
                  : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    );
  }
}
