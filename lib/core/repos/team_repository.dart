part of 'repositories.dart';

class TeamRepository {
  late final TeamServices _teamServices;
  late final PlayerServices _playerServices;

  TeamRepository() {
    _teamServices = TeamServices();
    _playerServices = PlayerServices();
  }

  Future<ApiReturnValue<List<Tim>>> getListTim(
      {required String idUser,
      required String idSekolah,
      required String idCabor}) async {
    return await _teamServices.getListTim(
        idUser: idUser, idSekolah: idSekolah, idCabor: idCabor);
  }

  Future<ApiReturnValue<String>> updateLogoTeam(
          String teamId, XFile image) async =>
      _teamServices.updateLogoTim(teamId, image);

  Future<ApiReturnValue<Tim>> createTeam(
          {required String idUser,
          required String idSchool,
          required String idCabor,
          required String namaTeam,
          required String pembina,
          required String pelatih,
          required String asistenPelatih,
          required String teamMedis,
          required String kordinatorSupporter,
          required String teamType,
          required XFile skkpImage}) =>
      _teamServices.createTeam(
          idUser: idUser,
          idSchool: idSchool,
          idCabor: idCabor,
          namaTeam: namaTeam,
          pembina: pembina,
          pelatih: pelatih,
          asistenPelatih: asistenPelatih,
          teamMedis: teamMedis,
          kordinatorSupporter: kordinatorSupporter,
          teamType: teamType,
          skkpImage: skkpImage);

  Future<ApiReturnValue<List<Player>>> getListPlayer(
          {required String idUser, required String idTim}) =>
      _playerServices.getListPlayer(idUser: idUser, idTim: idTim);

  Future<ApiReturnValue<Player>> createPlayer({
    required String idUser,
    required String idTim,
    required String playerName,
    required String tglLahir,
    required String nisn,
    required String posisi,
    required String noPunggung,
    XFile? foto,
    XFile? aktaLahir,
    XFile? kk,
  }) =>
      _playerServices.createPlayer(
          idUser: idUser,
          idTim: idTim,
          playerName: playerName,
          tglLahir: tglLahir,
          nisn: nisn,
          posisi: posisi,
          noPunggung: noPunggung,
          foto: foto,
          aktaLahir: aktaLahir,
          kk: kk);
}
