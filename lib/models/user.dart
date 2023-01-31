import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String username;
  final String nama;
  final String level;
  final bool sessId;

  const User(
      {required this.userId,
      required this.username,
      required this.nama,
      required this.level,
      required this.sessId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['user_id'],
        username: json['username'],
        nama: json['nama'],
        level: json['level'],
        sessId: json['sess_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'nama': nama,
      'level': level,
      'sess_id': sessId
    };
  }

  @override
  List<Object?> get props => [userId, username, nama, level, sessId];
}
