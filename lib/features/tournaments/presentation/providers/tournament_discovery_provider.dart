import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/tournament.dart';
import '../../data/repositories/tournament_repository_provider.dart';

final tournamentDiscoveryProvider = StreamProvider<List<Tournament>>((ref) {
  final repository = ref.watch(tournamentRepositoryProvider);
  return repository.watchTournaments();
});

final upcomingTournamentsProvider = Provider<AsyncValue<List<Tournament>>>((
  ref,
) {
  return ref
      .watch(tournamentDiscoveryProvider)
      .whenData(
        (tournaments) => tournaments
            .where((t) => t.startTime.isAfter(DateTime.now()))
            .toList(),
      );
});
