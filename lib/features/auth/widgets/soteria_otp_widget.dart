import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';

class SoteriaOtpWidget extends StatefulWidget {
  const SoteriaOtpWidget({
    super.key,
    required this.onChanged,
    this.length = 6,
    this.enabled = true,
  });

  final ValueChanged<String> onChanged;
  final int length;
  final bool enabled;

  @override
  State<SoteriaOtpWidget> createState() => _SoteriaOtpWidgetState();
}

class _SoteriaOtpWidgetState extends State<SoteriaOtpWidget> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (index) => TextEditingController());
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length > 1) {
      // Handle paste
      final clean = value.replaceAll(RegExp(r'[^0-9]'), '');
      for (var i = 0; i < clean.length && (index + i) < widget.length; i++) {
        _controllers[index + i].text = clean[i];
      }
      _notify();
      final nextIndex = index + clean.length;
      if (nextIndex < widget.length) {
        _focusNodes[nextIndex].requestFocus();
      } else {
        _focusNodes.last.unfocus();
      }
      return;
    }

    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    _notify();
  }

  void _onKeyEvent(KeyEvent event, int index) {
    if (event is KeyDownEvent && 
        event.logicalKey == LogicalKeyboardKey.backspace && 
        _controllers[index].text.isEmpty && 
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _notify() {
    final code = _controllers.map((c) => c.text).join();
    widget.onChanged(code);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: 48.w,
          height: 56.h,
          child: KeyboardListener(
            focusNode: FocusNode(), // Dummy to catch events
            onKeyEvent: (event) => _onKeyEvent(event, index),
            child: GlassSurface(
              borderRadius: SoteriaRadius.brMd,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                enabled: widget.enabled,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(widget.length), // Allow full length for paste then truncate
                ],
                onChanged: (val) => _onChanged(val, index),
                autofillHints: const [AutofillHints.oneTimeCode],
              ),
            ),
          ),
        );
      }),
    );
  }
}
