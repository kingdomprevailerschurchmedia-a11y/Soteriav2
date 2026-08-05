import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_status.dart';

void main() {
  group('TournamentStatus', () {
    test('enum has all required states', () {
      expect(TournamentStatus.values, contains(TournamentStatus.upcoming));
      expect(
        TournamentStatus.values,
        contains(TournamentStatus.registrationOpen),
      );
      expect(
        TournamentStatus.values,
        contains(TournamentStatus.registrationClosed),
      );
      expect(TournamentStatus.values, contains(TournamentStatus.live));
      expect(TournamentStatus.values, contains(TournamentStatus.completed));
    });
  });
}
