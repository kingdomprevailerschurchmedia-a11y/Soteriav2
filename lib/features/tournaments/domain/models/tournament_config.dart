import 'package:flutter/foundation.dart';

@immutable
class TournamentConfig {
  final int maxRegistration;
  final double defaultFee;

  const TournamentConfig({
    required this.maxRegistration,
    required this.defaultFee,
  });

  const TournamentConfig.defaults() : maxRegistration = 100, defaultFee = 5.0;
}
