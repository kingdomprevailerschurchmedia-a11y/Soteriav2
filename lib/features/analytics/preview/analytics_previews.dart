import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/analytics/presentation/screens/personal_performance_screen.dart';
import 'package:soteria/features/analytics/presentation/providers/analytics_providers.dart';
import 'package:soteria/features/analytics/preview/analytics_mock_data.dart';

class AnalyticsPreviews extends StatelessWidget {
  const AnalyticsPreviews({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPreview(
            'Performance - Active',
            AnalyticsMockData.getBasicAnalytics(),
          ),
          const SizedBox(height: 40),
          _buildPreview(
            'Performance - No Data',
            AnalyticsMockData.getNoDataAnalytics(),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(String title, dynamic mockData) {
    return SizedBox(
      height: 600, // Constraint for preview list
      child: ProviderScope(
        overrides: [
          personalPerformanceAnalyticsProvider.overrideWith((ref) => mockData),
        ],
        child: PersonalPerformanceScreen(),
      ),
    );
  }
}
