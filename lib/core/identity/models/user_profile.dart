import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  final String firstName;
  final String lastName;
  final String displayName;
  final String username;
  final String email;
  final String? avatarUrl;
  final String selectedAvatarId;
  final String? academicLevel;
  final String? institution;
  final String? faculty;
  final String? department;
  final String country;
  final String timezone;
  final String language;
  final List<String> interests;
  final String bio;

  const UserProfile({
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.username,
    required this.email,
    this.avatarUrl,
    this.selectedAvatarId = 'socrates',
    this.academicLevel,
    this.institution,
    this.faculty,
    this.department,
    this.country = 'Nigeria',
    this.timezone = 'Africa/Lagos',
    this.language = 'en',
    this.interests = const [],
    this.bio = '',
  });

  String get fullName => '$firstName $lastName';

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? displayName,
    String? username,
    String? email,
    String? avatarUrl,
    String? selectedAvatarId,
    String? academicLevel,
    String? institution,
    String? faculty,
    String? department,
    String? country,
    String? timezone,
    String? language,
    List<String>? interests,
    String? bio,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      selectedAvatarId: selectedAvatarId ?? this.selectedAvatarId,
      academicLevel: academicLevel ?? this.academicLevel,
      institution: institution ?? this.institution,
      faculty: faculty ?? this.faculty,
      department: department ?? this.department,
      country: country ?? this.country,
      timezone: timezone ?? this.timezone,
      language: language ?? this.language,
      interests: interests ?? this.interests,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'username': username,
      'email': email,
      'avatarUrl': avatarUrl,
      'selectedAvatarId': selectedAvatarId,
      'academicLevel': academicLevel,
      'institution': institution,
      'faculty': faculty,
      'department': department,
      'country': country,
      'timezone': timezone,
      'language': language,
      'interests': interests,
      'bio': bio,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      displayName: map['displayName'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'],
      selectedAvatarId: map['selectedAvatarId'] ?? 'socrates',
      academicLevel: map['academicLevel'],
      institution: map['institution'],
      faculty: map['faculty'],
      department: map['department'],
      country: map['country'] ?? 'Nigeria',
      timezone: map['timezone'] ?? 'Africa/Lagos',
      language: map['language'] ?? 'en',
      interests: List<String>.from(map['interests'] ?? []),
      bio: map['bio'] ?? '',
    );
  }
}
