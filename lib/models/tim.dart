import 'package:equatable/equatable.dart';

class Tim extends Equatable {
  const Tim({
    required this.id,
    required this.idUser,
    required this.idSekolah,
    required this.idCabor,
    required this.logoTeam,
    required this.namaTeam,
    required this.pembina,
    required this.pelatih,
    required this.asistenPelatih,
    required this.teamMedis,
    required this.kordinatorSupporter,
  });

  final String id;
  final String idUser;
  final String idSekolah;
  final String idCabor;
  final String? logoTeam;
  final String namaTeam;
  final String pembina;
  final String pelatih;
  final String asistenPelatih;
  final String teamMedis;
  final String kordinatorSupporter;

  factory Tim.fromMap(Map<String, dynamic> map) {
    return Tim(
      id: "${map['id']}",
      idUser: map['id_user'],
      idSekolah: map['id_sekolah'],
      idCabor: map['id_cabor'],
      logoTeam: map['logo'],
      namaTeam: map['nama_team'],
      pembina: map['pembina'],
      pelatih: map['pelatih'],
      asistenPelatih: map['asisten_pelatih'] ?? map['ass_pelatih'],
      teamMedis: map['team_medis'],
      kordinatorSupporter: map['kordinator_supporter'] ?? map['kor_suporter'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        idUser,
        idSekolah,
        idCabor,
        logoTeam,
        namaTeam,
        pembina,
        pelatih,
        asistenPelatih,
        teamMedis,
        kordinatorSupporter
      ];
}
