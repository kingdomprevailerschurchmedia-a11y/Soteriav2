import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/screens/quiz_gameplay_screen.dart';
import '../presentation/screens/quiz_results_screen.dart';
import '../presentation/providers/quiz_providers.dart';
import '../domain/models/quiz_enums.dart';
import '../certification/certification_debug_tools.dart';
import 'gameplay_previews.dart';

class CertificationPreviews extends StatelessWidget {
  const CertificationPreviews({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPreview(
            'E2E Flow - Active Gameplay',
            GameplayPreviews.active(),
            showTools: true,
          ),
          const SizedBox(height: 40),
          _buildPreview(
            'E2E Flow - Results Screen',
            const QuizResultsScreen(),
            showTools: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(String title, Widget child, {bool showTools = false}) {
    return SizedBox(
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Stack(
              children: [
                child,
                if (showTools)
                  const Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: CertificationDebugTools(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
