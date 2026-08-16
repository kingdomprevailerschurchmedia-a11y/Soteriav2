import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_bundle.freezed.dart';
part 'coin_bundle.g.dart';

@freezed
abstract class CoinBundle with _$CoinBundle {
  const factory CoinBundle({
    required String id,
    required String name,
    required int coins,
    required double price,
    required String icon,
  }) = _CoinBundle;

  factory CoinBundle.fromJson(Map<String, dynamic> json) => _$CoinBundleFromJson(json);
}
