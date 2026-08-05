import 'package:flutter/material.dart';

class QualityToolsOverlay extends StatefulWidget {
  final Widget child;
  const QualityToolsOverlay({super.key, required this.child});

  @override
  State<QualityToolsOverlay> createState() => _QualityToolsOverlayState();
}

class _QualityToolsOverlayState extends State<QualityToolsOverlay> {
  bool _showSpacing = false;
  bool _showSemantics = false;

  @override
  Widget build(BuildContext context) {
    Widget current = widget.child;

    if (_showSemantics) {
      current = SemanticsDebugger(child: current);
    }

    if (_showSpacing) {
      current = _SpacingOverlay(child: current);
    }

    return Stack(
      children: [
        current,
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            children: [
              _ToolButton(
                icon: Icons.grid_4x4_rounded,
                active: _showSpacing,
                onPressed: () => setState(() => _showSpacing = !_showSpacing),
              ),
              const SizedBox(height: 8),
              _ToolButton(
                icon: Icons.record_voice_over_rounded,
                active: _showSemantics,
                onPressed: () =>
                    setState(() => _showSemantics = !_showSemantics),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToolButton extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onPressed;

  const _ToolButton({
    required this.icon,
    required this.active,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: active ? Colors.blue : Colors.grey[900],
      onPressed: onPressed,
      child: Icon(icon, color: Colors.white),
    );
  }
}

class _SpacingOverlay extends StatelessWidget {
  final Widget child;
  const _SpacingOverlay({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(foregroundPainter: _SpacingPainter(), child: child);
  }
}

class _SpacingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.pink.withValues(alpha: 0.1)
      ..strokeWidth = 0.5;

    // Draw a 8dp grid (Soteria standard)
    for (double i = 0; i < size.width; i += 8) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), linePaint);
    }
    for (double i = 0; i < size.height; i += 8) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
