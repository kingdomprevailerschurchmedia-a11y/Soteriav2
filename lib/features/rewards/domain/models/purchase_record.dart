import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_record.freezed.dart';
part 'purchase_record.g.dart';

enum PurchaseStatus {
  pending,
  completed,
  failed,
  refunded,
}

enum VerificationState {
  unverified,
  pending,
  verified,
  failed,
}

@freezed
abstract class PurchaseRecord with _$PurchaseRecord {
  const factory PurchaseRecord({
    required String purchaseId,
    required String userId,
    required String productId,
    required String storeProductId,
    required String platform, // 'ios' or 'android'
    required String platformTransactionId,
    required String purchaseType, // 'one_time' or 'subscription'
    @Default(PurchaseStatus.pending) PurchaseStatus status,
    @Default(VerificationState.unverified) VerificationState verificationState,
    required DateTime createdAt,
    DateTime? processedAt,
    @Default({}) Map<String, dynamic> metadata,
  }) = _PurchaseRecord;

  factory PurchaseRecord.fromJson(Map<String, dynamic> json) => _$PurchaseRecordFromJson(json);
}
