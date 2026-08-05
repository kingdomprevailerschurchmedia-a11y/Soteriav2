import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/tournament.dart';
import '../../data/repositories/tournament_repository_provider.dart';

final tournamentDetailsProvider = StreamProvider.family<Tournament?, String>((
  ref,
  id,
) {
  final repository = ref.watch(tournamentRepositoryProvider);
  return repository.watchTournament(id);
});
