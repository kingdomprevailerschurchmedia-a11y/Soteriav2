import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/blur/soteria_blur.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';

class GamePausedView extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onQuit;

  const GamePausedView({
    super.key,
    required this.onResume,
    required this.onQuit,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: SoteriaBlur.medium,
        sigmaY: SoteriaBlur.medium,
      ),
      child: Container(
        color: Colors.black.withValues(alpha: 0.4),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PAUSED',
                style: context.displayMedium.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 8.0,
                ),
              ),
              SizedBox(height: SoteriaSpacing.xxl),
              ElevatedButton(onPressed: onResume, child: const Text('RESUME')),
              TextButton(
                onPressed: onQuit,
                child: Text(
                  'QUIT SESSION',
                  style: TextStyle(color: SoteriaColors.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
