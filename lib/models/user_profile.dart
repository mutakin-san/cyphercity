// To parse this JSON data, do
//
//     final userProfile = userProfileFromMap(jsonString);

import 'dart:convert';

UserProfile userProfileFromMap(String str) =>
    UserProfile.fromMap(json.decode(str));

String userProfileToMap(UserProfile data) => json.encode(data.toMap());

class UserProfile {
  UserProfile({
    required this.userId,
    required this.username,
    required this.namaLengkap,
    required this.email,
    required this.noHp,
    required this.statusSekolah,
  });

  final String userId;
  final String username;
  final String namaLengkap;
  final String email;
  final String noHp;
  final String statusSekolah;

  factory UserProfile.fromMap(Map<String, dynamic> json) => UserProfile(
        userId: json["user_id"],
        username: json["username"],
        namaLengkap: json["nama_lengkap"],
        email: json["email"],
        noHp: json["no_hp"],
        statusSekolah: json["status_sekolah"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "username": username,
        "nama_lengkap": namaLengkap,
        "email": email,
        "no_hp": noHp,
        "status_sekolah": statusSekolah,
      };
}
