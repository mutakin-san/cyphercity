part of 'repositories.dart';


class SchoolRepository{

  final SchoolServices _network = SchoolServices();

  Future<ApiReturnValue<School?>> getDetailSchool(idUser) async {
    return await _network.getDetailSchool(idUser: idUser);
  }

  Future<bool> editBiodata({required String? kode, required String idUser, required String namaSekolah, required String npsn, required String biodata, XFile? image}) async {

    final result = await _network.editSchoolBiodata(kode: kode, idUser: idUser, namaSekolah: namaSekolah, npsn: npsn, biodata: biodata, image: image);
    if (result.data != null && result.data!) {
      return result.data!;
    } else {
      throw Exception(result.message);
    }
  }
}