import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/player_statistics.dart';

final playerStatisticsProvider = Provider<PlayerStatistics>((ref) {
  // Mock statistics for now
  return const PlayerStatistics(
    totalQuestionsAnswered: 1250,
    overallAccuracy: 0.85,
    totalStudyTime: Duration(hours: 12, minutes: 30),
    averageResponseTimeMs: 4200,
  );
});
