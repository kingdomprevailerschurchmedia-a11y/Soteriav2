import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/player/presentation/providers/mission_providers.dart';
import 'package:soteria/features/player/presentation/screens/competitive_missions_screen.dart';
import 'package:soteria/features/player/presentation/screens/mission_details_screen.dart';
import 'package:soteria/features/player/presentation/screens/mission_history_screen.dart';
import 'package:soteria/features/player/preview/mission_fixtures.dart';
import 'package:soteria/features/player/domain/models/competitive_mission.dart';

class MissionPreviews {
  static Widget full() {
    return _wrapper(
      const CompetitiveMissionsScreen(),
      missions: MissionFixtures.allActive(),
    );
  }

  static Widget empty() {
    return _wrapper(
      const CompetitiveMissionsScreen(),
      missions: [],
    );
  }

  static Widget details() {
    return _wrapper(
      MissionDetailsScreen(missionId: MissionFixtures.dailyPlay.id),
      missions: MissionFixtures.allActive(),
    );
  }

  static Widget history() {
    return _wrapper(
      const MissionHistoryScreen(),
      history: [
        MissionFixtures.claimedHistory(),
        MissionFixtures.claimedHistory().copyWith(
          state: MissionFixtures.claimedHistory().state.copyWith(
            missionId: MissionFixtures.dailyWin.id,
          ),
        ),
      ],
    );
  }

  static Widget _wrapper(
    Widget child, {
    List<CompetitiveMission>? missions,
    List<CompetitiveMission>? history,
  }) {
    return ProviderScope(
      overrides: [
        activeMissionsProvider.overrideWith((ref) => Stream.value(missions ?? [])),
        dailyMissionsProvider.overrideWith((ref) => AsyncValue.data(
              missions?.where((m) => m.definition.period == MissionPeriod.daily).toList() ?? [],
            )),
        weeklyMissionsProvider.overrideWith((ref) => AsyncValue.data(
              missions?.where((m) => m.definition.period == MissionPeriod.weekly).toList() ?? [],
            )),
        seasonalMissionsProvider.overrideWith((ref) => AsyncValue.data(
              missions?.where((m) => m.definition.period == MissionPeriod.seasonal).toList() ?? [],
            )),
        missionHistoryProvider.overrideWith((ref) => Future.value(history ?? [])),
      ],
      child: child,
    );
  }
}
