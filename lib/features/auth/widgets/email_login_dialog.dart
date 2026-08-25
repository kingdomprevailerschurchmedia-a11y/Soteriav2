import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/utils/identity_validator.dart';
import '../models/login_state.dart';
import '../providers/login_notifier.dart';

class EmailLoginDialog extends ConsumerStatefulWidget {
  const EmailLoginDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (context) => const EmailLoginDialog(),
    );
  }

  @override
  ConsumerState<EmailLoginDialog> createState() => _EmailLoginDialogState();
}

class _EmailLoginDialogState extends ConsumerState<EmailLoginDialog> {
  int _step = 1; // 1: Email, 2: Password
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = ref.read(loginProvider).email;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    final email = _emailController.text.trim();
    if (!IdentityValidator.isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }
    ref.read(loginProvider.notifier).updateEmail(email);
    setState(() => _step = 2);
  }

  Future<void> _login() async {
    final password = _passwordController.text;
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password.')),
      );
      return;
    }
    ref.read(loginProvider.notifier).updatePassword(password);
    await ref.read(loginProvider.notifier).login();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);

    // Close dialog on success
    ref.listen(loginProvider, (previous, next) {
      if (previous?.isLoading == true && !next.isLoading && next.error == null) {
        Navigator.of(context).pop();
      }
    });

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _step == 1 ? 'Email Address' : 'Password',
                  style: context.titleLarge.copyWith(
                    color: const Color(0xFF1A1A1A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close, color: Colors.grey[400], size: 24.sp),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            if (_step == 1) _buildEmailStep(state) else _buildPasswordStep(state),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailStep(LoginState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          controller: _emailController,
          hintText: 'Email Address',
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16.h),
        Text(
          'Enter your email address. We\'ll ask for your password next.',
          style: context.bodySmall.copyWith(
            color: Colors.grey[600],
            fontSize: 13.sp,
            height: 1.4,
          ),
        ),
        SizedBox(height: 32.h),
        _buildButton(
          label: 'Next',
          onPressed: _nextStep,
        ),
      ],
    );
  }

  Widget _buildPasswordStep(LoginState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          controller: _passwordController,
          hintText: 'Password',
          obscureText: _obscurePassword,
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            SizedBox(
              width: 24.w,
              height: 24.w,
              child: Checkbox(
                value: !_obscurePassword,
                onChanged: (val) => setState(() => _obscurePassword = !val!),
                activeColor: SoteriaColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'Show Password',
              style: context.bodySmall.copyWith(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                ref
                    .read(navigationServiceProvider)
                    .push('${SoteriaRoutes.auth}/verify/passwordRecovery');
              },
              child: Text(
                'Forgot Password?',
                style: context.bodySmall.copyWith(
                  color: SoteriaColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        if (state.error != null) ...[
          SizedBox(height: 16.h),
          Text(
            state.error!,
            style: context.bodySmall.copyWith(color: Colors.red, fontSize: 12.sp),
          ),
        ],
        SizedBox(height: 32.h),
        _buildButton(
          label: 'Sign In',
          onPressed: state.isLoading ? null : _login,
          isLoading: state.isLoading,
        ),
        SizedBox(height: 12.h),
        Center(
          child: TextButton(
            onPressed: () => setState(() => _step = 1),
            child: Text(
              'Change Email',
              style: context.bodySmall.copyWith(
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: context.bodyLarge.copyWith(color: const Color(0xFF1A1A1A)),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.bodyLarge.copyWith(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF5F5F5),
          foregroundColor: const Color(0xFF1A1A1A),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF1A1A1A),
                ),
              )
            : Text(
                label,
                style: context.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
      ),
    );
  }
}
