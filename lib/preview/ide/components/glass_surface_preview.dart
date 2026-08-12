import 'package:flutter/material.dart';
import '../../../core/widgets/glass_surface.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const GlassSurfacePreview());
}

class GlassSurfacePreview extends StatelessWidget {
  const GlassSurfacePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: GlassSurface(
            padding: const EdgeInsets.all(32.0),
            borderRadius: BorderRadius.circular(24),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, color: Colors.white, size: 48),
                SizedBox(height: 16),
                Text(
                  'Premium Glass Effect',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'This component uses real-time blur and opacity design tokens.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
