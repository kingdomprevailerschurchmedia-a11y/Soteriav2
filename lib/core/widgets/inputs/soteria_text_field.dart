import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';

/// A premium text input component with support for labels, icons, and obscuring text.
///
/// Integrated with the Soteria Design Language for consistent styling of
/// borders, colors, and typography.
class SoteriaTextField extends StatefulWidget {
  const SoteriaTextField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.isSearch = false,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.autofillHints,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isSearch;
  final bool enabled;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;

  @override
  State<SoteriaTextField> createState() => _SoteriaTextFieldState();
}

class _SoteriaTextFieldState extends State<SoteriaTextField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: context.labelLarge.copyWith(color: SoteriaColors.textSecondary),
          ),
          SizedBox(height: SoteriaSpacing.sm),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: _isObscured,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          onChanged: widget.onChanged,
          autofillHints: widget.autofillHints,
          style: context.bodyLarge.copyWith(
            color: widget.enabled ? null : SoteriaColors.muted,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: context.bodyLarge.copyWith(color: SoteriaColors.hints),
            filled: true,
            fillColor: SoteriaColors.surface,
            prefixIcon: widget.prefixIcon != null 
                ? Icon(widget.prefixIcon, color: SoteriaColors.muted, size: 20) 
                : null,
            suffixIcon: widget.obscureText 
                ? IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      color: SoteriaColors.muted,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _isObscured = !_isObscured),
                  ) 
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: SoteriaSpacing.md,
              vertical: SoteriaSpacing.md,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: SoteriaRadius.brMd,
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: SoteriaRadius.brMd,
              borderSide: const BorderSide(color: SoteriaColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: SoteriaRadius.brMd,
              borderSide: const BorderSide(color: SoteriaColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: SoteriaRadius.brMd,
              borderSide: const BorderSide(color: SoteriaColors.error, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
