import 'package:flutter/foundation.dart';

@immutable
class UserReputation {
  final int fairPlayScore; // 0 to 100
  final double sportsmanshipRating; // 0.0 to 5.0
  final int reportCount;
  final int penaltyPoints;
  final bool isVerified;

  const UserReputation({
    this.fairPlayScore = 100,
    this.sportsmanshipRating = 5.0,
    this.reportCount = 0,
    this.penaltyPoints = 0,
    this.isVerified = false,
  });

  UserReputation copyWith({
    int? fairPlayScore,
    double? sportsmanshipRating,
    int? reportCount,
    int? penaltyPoints,
    bool? isVerified,
  }) {
    return UserReputation(
      fairPlayScore: fairPlayScore ?? this.fairPlayScore,
      sportsmanshipRating: sportsmanshipRating ?? this.sportsmanshipRating,
      reportCount: reportCount ?? this.reportCount,
      penaltyPoints: penaltyPoints ?? this.penaltyPoints,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
