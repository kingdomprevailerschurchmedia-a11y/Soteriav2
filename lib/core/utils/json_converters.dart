import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const TimestampConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    try {
      if (json is Timestamp) return json.toDate();
      if (json is DateTime) return json;
      if (json is String) return DateTime.tryParse(json);
      // Handle potential Map from json_serializable if it was encoded as a Timestamp map
      if (json is Map && json.containsKey('_seconds')) {
        return Timestamp(json['_seconds'] as int, json['_nanoseconds'] as int).toDate();
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  dynamic toJson(DateTime? object) => object?.toIso8601String();
}

/// Converter for required (non-nullable) [DateTime] fields from Firestore [Timestamp].
class RequiredTimestampConverter implements JsonConverter<DateTime, dynamic> {
  const RequiredTimestampConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) return json.toDate();
    if (json is DateTime) return json;
    if (json is String) return DateTime.parse(json);
    if (json is Map && json.containsKey('_seconds')) {
      return Timestamp(json['_seconds'] as int, json['_nanoseconds'] as int).toDate();
    }
    // Fallback or throw informative error
    if (json == null) {
      throw ArgumentError('Required timestamp field is null');
    }
    throw ArgumentError('Expected Timestamp, DateTime or String, but got ${json.runtimeType}');
  }

  @override
  dynamic toJson(DateTime object) => object.toIso8601String();
}

/// Converter for engagement dates (YYYY-MM-DD) that can handle Firestore [Timestamp].
class EngagementDateConverter implements JsonConverter<String?, dynamic> {
  const EngagementDateConverter();

  @override
  String? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is Timestamp) {
      final date = json.toDate();
      return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    }
    return null;
  }

  @override
  dynamic toJson(String? object) => object;
}
