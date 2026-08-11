import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_season.dart';
import '../presentation/providers/season_providers.dart';
import '../presentation/widgets/season_header.dart';
import '../../../../core/services/time_service.dart';

class SeasonPreviewWrapper extends StatelessWidget {
  final CompetitiveSeason? mockSeason;
  final DateTime mockNow;

  const SeasonPreviewWrapper({
    super.key,
    required this.mockSeason,
    required this.mockNow,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        currentSeasonProvider.overrideWith((ref) => Stream.value(mockSeason)),
        timeServiceProvider.overrideWithValue(_MockTimeService(mockNow)),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFF0B012A),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [SeasonHeader()],
          ),
        ),
      ),
    );
  }
}

class _MockTimeService implements TimeService {
  final DateTime _now;
  _MockTimeService(this._now);

  @override
  DateTime now() => _now;
  @override
  DateTime nowUtc() => _now.toUtc();
}

class SeasonPreviews {
  static CompetitiveSeason mock({
    required String name,
    required SeasonStatus status,
    required DateTime start,
    required DateTime end,
    int number = 1,
    bool isCurrent = true,
  }) {
    return CompetitiveSeason(
      seasonId: 's_$number',
      name: name,
      status: status,
      startAt: start,
      endAt: end,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      seasonNumber: number,
      isCurrent: isCurrent,
      description: 'The ultimate battle for cybersecurity supremacy.',
    );
  }

  static Widget active() {
    final now = DateTime.now();
    return SeasonPreviewWrapper(
      mockNow: now,
      mockSeason: mock(
        name: 'Cyber Sentinel',
        status: SeasonStatus.active,
        start: now.subtract(const Duration(days: 10)),
        end: now.add(const Duration(days: 20)),
      ),
    );
  }

  static Widget endingSoon() {
    final now = DateTime.now();
    return SeasonPreviewWrapper(
      mockNow: now,
      mockSeason: mock(
        name: 'Binary Breach',
        status: SeasonStatus.active,
        start: now.subtract(const Duration(days: 29)),
        end: now.add(const Duration(hours: 3, minutes: 45)),
        number: 2,
      ),
    );
  }

  static Widget upcoming() {
    final now = DateTime.now();
    return SeasonPreviewWrapper(
      mockNow: now,
      mockSeason: mock(
        name: 'Quantum Shield',
        status: SeasonStatus.upcoming,
        start: now.add(const Duration(days: 2)),
        end: now.add(const Duration(days: 32)),
        number: 3,
      ),
    );
  }

  static Widget completed() {
    final now = DateTime.now();
    return SeasonPreviewWrapper(
      mockNow: now,
      mockSeason: mock(
        name: 'Legacy Protocol',
        status: SeasonStatus.completed,
        start: now.subtract(const Duration(days: 40)),
        end: now.subtract(const Duration(days: 10)),
        number: 1,
      ),
    );
  }
}
