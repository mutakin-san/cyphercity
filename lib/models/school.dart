import 'package:equatable/equatable.dart';

class School extends Equatable {
  const School({
    required this.id,
    required this.idUser,
    required this.idRegion,
    required this.namaSekolah,
    required this.npsn,
    required this.biodata,
    required this.logo,
    required this.gambar,
    required this.status,
  });

  final String id;
  final String idUser;
  final String idRegion;
  final String namaSekolah;
  final String npsn;
  final String biodata;
  final String logo;
  final String gambar;
  final String status;

  factory School.fromMap(Map<String, dynamic> map) {
    return School(
        id: map['id'] ?? map['id_sekolah'],
        idUser: map['id_user'],
        idRegion: map['id_region'],
        namaSekolah: map['nama_sekolah'],
        npsn: map['npsn'],
        biodata: map['biodata'],
        logo: map['logo'],
        gambar: map['gambar'],
        status: map['status']);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "id_user": idUser,
      "id_region": idRegion,
      "nama_sekolah": namaSekolah,
      "npsn": npsn,
      "biodata": biodata,
      "logo": logo,
      "gambar": gambar,
      "status": status,
    };
  }

  @override
  List<Object?> get props =>
      [id, idUser, idRegion, namaSekolah, npsn, biodata, logo, gambar, status];
}
