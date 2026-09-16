// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PurchaseRecord _$PurchaseRecordFromJson(Map<String, dynamic> json) =>
    _PurchaseRecord(
      purchaseId: json['purchaseId'] as String,
      userId: json['userId'] as String,
      productId: json['productId'] as String,
      storeProductId: json['storeProductId'] as String,
      platform: json['platform'] as String,
      platformTransactionId: json['platformTransactionId'] as String,
      purchaseType: json['purchaseType'] as String,
      status:
          $enumDecodeNullable(_$PurchaseStatusEnumMap, json['status']) ??
          PurchaseStatus.pending,
      verificationState:
          $enumDecodeNullable(
            _$VerificationStateEnumMap,
            json['verificationState'],
          ) ??
          VerificationState.unverified,
      createdAt: DateTime.parse(json['createdAt'] as String),
      processedAt: json['processedAt'] == null
          ? null
          : DateTime.parse(json['processedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$PurchaseRecordToJson(
  _PurchaseRecord instance,
) => <String, dynamic>{
  'purchaseId': instance.purchaseId,
  'userId': instance.userId,
  'productId': instance.productId,
  'storeProductId': instance.storeProductId,
  'platform': instance.platform,
  'platformTransactionId': instance.platformTransactionId,
  'purchaseType': instance.purchaseType,
  'status': _$PurchaseStatusEnumMap[instance.status]!,
  'verificationState': _$VerificationStateEnumMap[instance.verificationState]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'processedAt': instance.processedAt?.toIso8601String(),
  'metadata': instance.metadata,
};

const _$PurchaseStatusEnumMap = {
  PurchaseStatus.pending: 'pending',
  PurchaseStatus.completed: 'completed',
  PurchaseStatus.failed: 'failed',
  PurchaseStatus.refunded: 'refunded',
};

const _$VerificationStateEnumMap = {
  VerificationState.unverified: 'unverified',
  VerificationState.pending: 'pending',
  VerificationState.verified: 'verified',
  VerificationState.failed: 'failed',
};
