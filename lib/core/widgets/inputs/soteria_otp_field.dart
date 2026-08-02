import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class SoteriaOtpField extends StatefulWidget {
  const SoteriaOtpField({super.key, this.length = 4, this.onCompleted});

  final int length;
  final ValueChanged<String>? onCompleted;

  @override
  State<SoteriaOtpField> createState() => _SoteriaOtpFieldState();
}

class _SoteriaOtpFieldState extends State<SoteriaOtpField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        final code = _controllers.map((c) => c.text).join();
        widget.onCompleted?.call(code);
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.length,
        (index) => SizedBox(
          width: 60,
          child: TextFormField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            autofocus: index == 0,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: context.headlineMedium,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: SoteriaColors.surface,
              contentPadding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
              enabledBorder: OutlineInputBorder(
                borderRadius: SoteriaRadius.brMd,
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: SoteriaRadius.brMd,
                borderSide: const BorderSide(color: SoteriaColors.primary),
              ),
            ),
            onChanged: (value) => _onChanged(value, index),
          ),
        ),
      ),
    );
  }
}
