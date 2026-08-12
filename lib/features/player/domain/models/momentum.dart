import 'package:freezed_annotation/freezed_annotation.dart';

part 'momentum.freezed.dart';
part 'momentum.g.dart';

enum MomentumState { none, building, strong, peak, cooling }

@freezed
abstract class CompetitiveMomentum with _$CompetitiveMomentum {
  const factory CompetitiveMomentum({
    required String userId,
    required MomentumState state,
    required String reason,
    required double intensity, // 0.0 to 1.0
    required DateTime updatedAt,
    @Default([]) List<String> recentSignals, // e.g. "3 Wins", "New PB"
  }) = _CompetitiveMomentum;

  factory CompetitiveMomentum.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveMomentumFromJson(json);
}
