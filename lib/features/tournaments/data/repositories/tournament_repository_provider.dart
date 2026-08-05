import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import '../../domain/repositories/tournament_repository.dart';
import 'firestore_tournament_repository.dart';

final tournamentRepositoryProvider = Provider<TournamentRepository>((ref) {
  final database = ref.watch(firestoreDatabaseServiceProvider);
  return FirestoreTournamentRepository(database: database);
});
