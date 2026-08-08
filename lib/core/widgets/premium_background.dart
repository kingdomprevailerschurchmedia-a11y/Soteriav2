import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../design_system/colors/soteria_colors.dart';

class PremiumBackground extends StatefulWidget {
  const PremiumBackground({super.key, required this.child});

  final Widget child;

  @override
  State<PremiumBackground> createState() => _PremiumBackgroundState();
}

class _PremiumBackgroundState extends State<PremiumBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: SoteriaColors.backgroundGradient,
          ),
        ),

        // Ambient Radial Glow
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.5),
                radius: 1.2,
                colors: [
                  SoteriaColors.primary.withValues(alpha: 0.12),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Floating Particles
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _ParticlePainter(progress: _controller.value),
              );
            },
          ),
        ),

        // Noise Texture / Overlay
        Positioned.fill(
          child: Opacity(
            opacity: 0.015,
            child: Image.asset(
              'assets/images/splash_bg.png', // Reusing splash bg if it has texture
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Vignette
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.2),
                ],
                stops: const [0.7, 1.0],
              ),
            ),
          ),
        ),

        widget.child,
      ],
    );
  }
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({required this.progress});

  final double progress;
  final List<_Particle> _particles = List.generate(25, (index) => _Particle());

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.15);

    for (var particle in _particles) {
      final x =
          (particle.x +
              math.sin(progress * 2 * math.pi + particle.offset) * 0.02) *
          size.width;
      final y = ((particle.y - progress * particle.speed) % 1.0) * size.height;

      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

class _Particle {
  final double x = math.Random().nextDouble();
  final double y = math.Random().nextDouble();
  final double size = math.Random().nextDouble() * 1.5 + 0.5;
  final double speed = math.Random().nextDouble() * 0.05 + 0.02;
  final double offset = math.Random().nextDouble() * 2 * math.pi;
}
