import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/gradients/soteria_gradients.dart';

class SoteriaGradientText extends StatelessWidget {
  const SoteriaGradientText(
    this.text, {
    super.key,
    required this.style,
    this.gradient = SoteriaGradients.competition,
    this.textAlign,
  });

  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}
