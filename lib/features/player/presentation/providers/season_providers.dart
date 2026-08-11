import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_season.dart';
import '../../domain/models/season_countdown.dart';
import '../../domain/repositories/season_repository.dart';
import '../../data/repositories/firebase_season_repository.dart';
import '../../../../core/services/time_service.dart';

final seasonRepositoryProvider = Provider<SeasonRepository>((ref) {
  return FirebaseSeasonRepository(FirebaseFirestore.instance);
});

final currentSeasonProvider = StreamProvider<CompetitiveSeason?>((ref) {
  return ref.watch(seasonRepositoryProvider).watchCurrentSeason();
});

final seasonCountdownProvider = StreamProvider<SeasonCountdown>((ref) {
  final seasonAsync = ref.watch(currentSeasonProvider);

  return seasonAsync.when(
    data: (season) {
      if (season == null) {
        return Stream.value(SeasonCountdown.unavailable());
      }

      final timeService = ref.read(timeServiceProvider);

      // Emit immediately
      final initialNow = timeService.nowUtc();
      final initialRemaining = season.endAt.difference(initialNow);

      final controller = StreamController<SeasonCountdown>();
      controller.add(SeasonCountdown.fromDuration(initialRemaining));

      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final now = timeService.nowUtc();
        final remaining = season.endAt.difference(now);
        final countdown = SeasonCountdown.fromDuration(remaining);

        if (!controller.isClosed) {
          controller.add(countdown);
        }

        if (countdown.status == CountdownStatus.ended) {
          timer.cancel();
        }
      });

      ref.onDispose(() {
        timer.cancel();
        controller.close();
      });

      return controller.stream;
    },
    loading: () => Stream.value(SeasonCountdown.unavailable()),
    error: (_, __) => Stream.value(SeasonCountdown.unavailable()),
  );
});

final derivedSeasonStatusProvider = Provider<SeasonStatus>((ref) {
  final season = ref.watch(currentSeasonProvider).value;
  if (season == null) return SeasonStatus.archived;

  final timeService = ref.watch(timeServiceProvider);
  final now = timeService.nowUtc();

  if (now.isBefore(season.startAt)) return SeasonStatus.upcoming;
  if (now.isAfter(season.endAt)) return SeasonStatus.completed;

  // Logic for 'ending' (warning period: 24h)
  if (season.endAt.difference(now) < const Duration(hours: 24)) {
    return SeasonStatus.ending;
  }

  return SeasonStatus.active;
});
