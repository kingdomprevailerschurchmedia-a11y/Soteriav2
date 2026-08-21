import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import '../providers/login_notifier.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  late final TextEditingController _emailController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    final initialEmail = ref.read(loginProvider).email;
    _emailController = TextEditingController(text: initialEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    final notifier = ref.read(loginProvider.notifier);

    // Sync controller if email changes from elsewhere (like auto-fill)
    if (_emailController.text != state.email && state.email.isNotEmpty) {
      _emailController.text = state.email;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel(context, 'EMAIL ADDRESS'),
        SizedBox(height: 8.h),
        _buildTextField(
          context: context,
          controller: _emailController,
          hintText: 'name@example.com',
          prefixIcon: Icons.mail_rounded,
          onChanged: notifier.updateEmail,
          keyboardType: TextInputType.emailAddress,
          enabled: !state.isLoading,
        ),
        SizedBox(height: 16.h),
        _buildLabel(context, 'PASSWORD'),
        SizedBox(height: 8.h),
        _buildTextField(
          context: context,
          hintText: 'Enter your password',
          prefixIcon: Icons.lock_rounded,
          obscureText: _obscurePassword,
          onChanged: notifier.updatePassword,
          enabled: !state.isLoading,
          isPassword: true,
          onToggleVisibility: () =>
              setState(() => _obscurePassword = !_obscurePassword),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: state.isLoading
                  ? null
                  : () => notifier.toggleRememberMe(!state.rememberMe),
              child: Row(
                children: [
                  Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: const Color(0xFF7C4DFF).withValues(alpha: 0.8),
                        width: 1.5,
                      ),
                      color: state.rememberMe
                          ? const Color(0xFF7C4DFF)
                          : Colors.transparent,
                    ),
                    child: state.rememberMe
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Remember Me',
                    style: context.bodyMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: state.isLoading
                  ? null
                  : () => ref
                        .read(navigationServiceProvider)
                        .push('${SoteriaRoutes.auth}/verify/passwordRecovery'),
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
        SizedBox(height: 24.h),
        SoteriaButton.primary(
          label: 'SIGN IN',
          onPressed: state.isLoading ? null : () => notifier.login(),
          isLoading: state.isLoading,
          size: SoteriaButtonSize.lg,
        ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: context.labelSmall.copyWith(
        color: Colors.white.withValues(alpha: 0.4),
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700,
        fontSize: 12.sp,
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String hintText,
    required IconData prefixIcon,
    required ValueChanged<String>? onChanged,
    TextEditingController? controller,
    bool obscureText = false,
    bool enabled = true,
    TextInputType? keyboardType,
    bool isPassword = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: const Color(0xFF130F26).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF5E2BFF).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        enabled: enabled,
        keyboardType: keyboardType,
        style: context.bodyLarge.copyWith(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.bodyLarge.copyWith(
            color: Colors.white.withValues(alpha: 0.2),
            fontSize: 16.sp,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Icon(
              prefixIcon,
              color: const Color(0xFF7C4DFF).withValues(alpha: 0.8),
              size: 22.sp,
            ),
          ),
          suffixIcon: isPassword
              ? Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: IconButton(
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: const Color(0xFF7C4DFF).withValues(alpha: 0.6),
                      size: 20.sp,
                    ),
                    onPressed: onToggleVisibility,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18.h),
        ),
      ),
    );
  }
}
