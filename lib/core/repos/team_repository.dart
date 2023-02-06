part of 'repositories.dart';

class TeamRepository {
  late final TeamServices _teamServices;

  TeamRepository() {
    _teamServices = TeamServices();
  }
  
  Future<ApiReturnValue<List<Tim>>> getListTim({required String idUser, required String idSekolah}) async {
    return await _teamServices.getListTim(idUser: idUser, idSekolah: idSekolah);
  }
}
