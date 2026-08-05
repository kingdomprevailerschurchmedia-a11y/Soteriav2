import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/tournaments/presentation/providers/tournament_countdown_provider.dart';

void main() {
  test('tournamentCountdownProvider emits correct duration', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final targetDate = DateTime.now().add(const Duration(seconds: 5));
    final subscription = container.listen(
      tournamentCountdownProvider(targetDate),
      (previous, next) {},
    );

    // Initial state
    expect(
      container.read(tournamentCountdownProvider(targetDate)),
      const AsyncValue<Duration>.loading(),
    );

    // Wait for first tick
    await Future.delayed(const Duration(seconds: 1));

    final duration = container
        .read(tournamentCountdownProvider(targetDate))
        .value!;
    expect(duration.inSeconds, inInclusiveRange(3, 5));

    subscription.close();
  });
}
