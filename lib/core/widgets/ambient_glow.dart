import 'dart:ui';
import 'package:flutter/material.dart';

class AmbientGlow extends StatelessWidget {
  const AmbientGlow({
    super.key,
    required this.color,
    this.size = 200,
    this.blur = 100,
    this.opacity = 0.3,
  });

  final Color color;
  final double size;
  final double blur;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}
