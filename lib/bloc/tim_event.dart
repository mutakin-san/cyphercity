part of 'tim_bloc.dart';

abstract class TimEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTim extends TimEvent {
  final String idUser;
  final String idSchool;
  final String idCabor;

  LoadTim(this.idUser, this.idSchool, this.idCabor);

  @override
  List<Object?> get props => [idUser, idSchool, idCabor];
}

class AddNewTeam extends TimEvent {
  final String idUser;
  final String idSchool;
  final String idCabor;
  final String namaTeam;
  final String pembina;
  final String pelatih;
  final String asistenPelatih;
  final String teamMedis;
  final String kordinatorSupporter;
  final String teamType;
  final XFile skkpImage;

  AddNewTeam(
      {required this.idUser,
      required this.idSchool,
      required this.idCabor,
      required this.namaTeam,
      required this.pembina,
      required this.pelatih,
      required this.asistenPelatih,
      required this.teamMedis,
      required this.kordinatorSupporter,
      required this.skkpImage,
      required this.teamType});

  @override
  List<Object?> get props => [
        idUser,
        idSchool,
        idCabor,
        namaTeam,
        pembina,
        pelatih,
        asistenPelatih,
        teamMedis,
        kordinatorSupporter,
        teamType,
        skkpImage
      ];
}

class UpdateTeam extends TimEvent {
  final String idTim;
  final String idUser;
  final String idSchool;
  final String idCabor;
  final String namaTeam;
  final String pembina;
  final String pelatih;
  final String asistenPelatih;
  final String teamMedis;
  final String kordinatorSupporter;
  final String teamType;
  final XFile? skkpImage;

  UpdateTeam(
      {required this.idTim,
      required this.idUser,
      required this.idSchool,
      required this.idCabor,
      required this.namaTeam,
      required this.pembina,
      required this.pelatih,
      required this.asistenPelatih,
      required this.teamMedis,
      required this.kordinatorSupporter,
      this.skkpImage,
      required this.teamType});

  @override
  List<Object?> get props => [
        idTim,
        idUser,
        idSchool,
        idCabor,
        namaTeam,
        pembina,
        pelatih,
        asistenPelatih,
        teamMedis,
        kordinatorSupporter,
        teamType,
        skkpImage
      ];
}

class UpdateLogo extends TimEvent {
  final String teamId;
  final XFile image;

  UpdateLogo(this.teamId, this.image);

  @override
  List<Object?> get props => [teamId, image];
}
