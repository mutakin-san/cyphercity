import 'package:bloc/bloc.dart';
import '../models/school.dart';
import '../services/api_services.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

part 'school_state.dart';

class SchoolCubit extends Cubit<SchoolState> {
  late final ApiServices _apiServices;
  final http.Client _client;

  SchoolCubit(this._client) : super(SchoolInitial()) {
    _apiServices = ApiServices(_client);
  }


  Future<void> loadSchool(idUser) async {

    emit(SchoolLoading());

    final result =
        await _apiServices.getIDSekolah(idUser: idUser);

    if (result.data != null) {
      emit(SchoolLoaded(result.data!));
    } else {
      emit(SchoolFailed(result.message ?? "Something error"));
    }
  }


  Future<void> editBiodata({required String? kode, required String idUser, required String namaSekolah, required String npsn, required String biodata, XFile? image}) async {

    emit(SchoolLoading());

    final result = await _apiServices.editBiodataSekolah(kode: kode, idUser: idUser, namaSekolah: namaSekolah, npsn: npsn, biodata: biodata, image: image);
    if (result.data != null && result.data!) {
      await loadSchool(idUser);
    } else {
      emit(SchoolFailed("${result.message}"));
    }
  }
}
