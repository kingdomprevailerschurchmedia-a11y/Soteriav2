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
