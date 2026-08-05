import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';

class SoteriaTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool readOnly;
  final Iterable<String>? autofillHints;

  const SoteriaTextField({
    super.key,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
    this.autofillHints,
  });

  @override
  State<SoteriaTextField> createState() => _SoteriaTextFieldState();
}

class _SoteriaTextFieldState extends State<SoteriaTextField> {
  bool _isObscured = false;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SoteriaSpacing.sm),
        ],
        AnimatedContainer(
          duration: SoteriaAnimations.fast,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: SoteriaRadius.brMd,
            border: Border.all(
              color: _isFocused
                  ? SoteriaColors.primary.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.06),
              width: 1,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: SoteriaColors.primary.withValues(alpha: 0.1),
                      blurRadius: 15,
                      spreadRadius: -5,
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            obscureText: _isObscured,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            autofillHints: widget.autofillHints,
            style: context.bodyLarge.copyWith(
              color: widget.enabled
                  ? SoteriaColors.textPrimary
                  : SoteriaColors.muted,
            ),
            cursorColor: SoteriaColors.primary,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: context.bodyLarge.copyWith(color: SoteriaColors.hints),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: SoteriaColors.muted,
                      size: 20.sp,
                    )
                  : null,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _isObscured
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: SoteriaColors.muted,
                        size: 20.sp,
                      ),
                      onPressed: () =>
                          setState(() => _isObscured = !_isObscured),
                    )
                  : widget.suffixIcon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(SoteriaSpacing.md),
            ),
          ),
        ),
      ],
    );
  }
}
