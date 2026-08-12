import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/player/presentation/screens/competitive_history_screen.dart';
import '../../../features/player/presentation/providers/history_providers.dart';
import '../../../features/player/presentation/providers/season_providers.dart';
import '../../../features/player/domain/models/season_result.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const HistoryEmptyPreview());
}

class HistoryEmptyPreview extends StatelessWidget {
  const HistoryEmptyPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewScaffold(
      overrides: [
        competitiveHistorySummaryProvider.overrideWithValue(
          const AsyncValue.data(CompetitiveHistory(userId: 'u1', results: [])),
        ),
        currentSeasonProvider.overrideWith((ref) => Stream.value(null)),
      ],
      child: const CompetitiveHistoryScreen(),
    );
  }
}
