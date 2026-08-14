import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/competitive_statistics_service.dart';

final statisticsServiceProvider = Provider<CompetitiveStatisticsService>((ref) {
  return CompetitiveStatisticsService();
});
