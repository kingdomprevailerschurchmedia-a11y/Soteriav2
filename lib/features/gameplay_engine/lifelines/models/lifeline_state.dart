import 'lifeline_status.dart';

class LifelineState {
  final LifelineStatus status;
  final int remainingUses;
  final Duration? cooldownRemaining;

  const LifelineState({
    this.status = LifelineStatus.available,
    this.remainingUses = 1,
    this.cooldownRemaining,
  });

  LifelineState copyWith({
    LifelineStatus? status,
    int? remainingUses,
    Duration? cooldownRemaining,
  }) {
    return LifelineState(
      status: status ?? this.status,
      remainingUses: remainingUses ?? this.remainingUses,
      cooldownRemaining: cooldownRemaining ?? this.cooldownRemaining,
    );
  }
}
