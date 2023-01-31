import 'package:equatable/equatable.dart';

class Tim extends Equatable{
  const Tim({
    required this.idUser,
    required this.idSekolah,
    required this.idCabor,
    required this.namaTeam,
    required this.pembina,
    required this.pelatih,
    required this.asistenPelatih,
    required this.teamMedis,
    required this.kordinatorSupporter,
  });

  final String idUser;
  final String idSekolah;
  final String idCabor;
  final String namaTeam;
  final String pembina;
  final String pelatih;
  final String asistenPelatih;
  final String teamMedis;
  final String kordinatorSupporter;

  factory Tim.fromMap(Map<String, dynamic> map) {
    return Tim(
      idUser: map['id_user'],
      idSekolah: map['id_sekolah'],
      idCabor: map['id_cabor'],
      namaTeam: map['nama_team'],
      pembina: map['pembina'],
      pelatih: map['pelatih'],
      asistenPelatih: map['asisten_pelatih'],
      teamMedis: map['team_medis'],
      kordinatorSupporter: map['kordinator_supporter'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_user': idUser,
      'id_sekolah': idSekolah,
      'id_cabor': idCabor,
      'nama_team': namaTeam,
      'pembina': pembina,
      'pelatih': pelatih,
      'asisten_pelatih': asistenPelatih,
      'team_medis': teamMedis,
      'kordinator_supporter': kordinatorSupporter,
    };
  }
  
  @override
  List<Object?> get props => [idUser, idSekolah, idCabor, namaTeam, pembina, pelatih, asistenPelatih, teamMedis, kordinatorSupporter];
}
