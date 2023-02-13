import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String idRegion;
  final String username;
  final String nama;
  final String level;

  const User(
      {required this.userId,
      required this.idRegion,
      required this.username,
      required this.nama,
      required this.level});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: "${json['user_id']}",
      idRegion: "${json['id_region']}",
      username: json['username'],
      nama: json['nama'] ?? json['nama_lengkap'],
      level: json['level'] ?? json['status_sekolah'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'id_region': idRegion,
      'username': username,
      'nama': nama,
      'level': level,
    };
  }

  @override
  List<Object?> get props => [userId, username, nama, level];
}
