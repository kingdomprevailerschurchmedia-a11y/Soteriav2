import 'dart:ui';
import 'package:flutter/material.dart';

class SoteriaBackground extends StatelessWidget {
  const SoteriaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/dashboard_bg.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFF0B012A), // Fallback dark background
              );
            },
          ),
        ),
        // Simplier Darkening Overlay (Blur removed for performance)
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1E1045).withValues(alpha: 0.6),
                  const Color(0xFF0B012A).withValues(alpha: 0.85),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
