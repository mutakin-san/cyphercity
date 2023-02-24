part of 'team.dart';

class TeamServices {
  static final Client _client = Client();

  Future<ApiReturnValue<String>> updateLogoTim(
      String teamId, XFile image) async {
    try {
      final request = MultipartRequest("POST", Uri.parse(updateLogoTeamUrl));

      request.headers['content-type'] = 'multipart/form-data';

      request.files.add(await MultipartFile.fromPath('file', image.path));

      request.fields['id_tim'] = teamId;

      final result = await request.send();

      if (result.statusCode == 200) {
        final Map<String, dynamic> response =
            jsonDecode(await result.stream.bytesToString());
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          return ApiReturnValue(
              data: (apiResponse.response as Map<String, dynamic>)['logo'],
              message: apiResponse.message);
        } else {
          return ApiReturnValue(message: apiResponse.message);
        }
      } else {
        return ApiReturnValue(message: result.reasonPhrase);
      }
    } on SocketException {
      return const ApiReturnValue(message: "Tidak Ada Koneksi!");
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<List<Tim>>> getListTim(
      {required String idUser,
      required String idSekolah,
      required String idCabor}) async {
    late ApiReturnValue<List<Tim>> returnValue;

    try {
      final result = await _client.post(Uri.parse(getTeamUrl), body: {
        'id_user': idUser.trim(),
        'id_sekolah': idSekolah.trim(),
        'id_cabor': idCabor.trim(),
      });

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          final data = (apiResponse.response as List)
              .map((e) => Tim.fromMap(e))
              .toList();

          returnValue =
              ApiReturnValue(data: data, message: apiResponse.message);
        } else {
          returnValue = ApiReturnValue(data: [], message: apiResponse.message);
        }
      } else {
        returnValue = ApiReturnValue(message: result.reasonPhrase);
      }

      return returnValue;
    } on SocketException {
      return const ApiReturnValue(message: "Tidak Ada Koneksi!");
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<Tim>> createTeam(
      {String? idTim,
      required String idUser,
      required String idSchool,
      required String idCabor,
      required String namaTeam,
      required String pembina,
      required String pelatih,
      required String asistenPelatih,
      required String teamMedis,
      required String kordinatorSupporter,
      required String teamType,
      XFile? skkpImage}) async {
    late ApiReturnValue<Tim> returnValue;

    try {
      final request = MultipartRequest(
          "POST", Uri.parse(idTim != null ? updateTeamUrl : createTeamUrl));

      request.headers['content-type'] = 'multipart/form-data';

      if (skkpImage != null) {
        request.files.add(await MultipartFile.fromPath('file', skkpImage.path));
      }

      if (idTim != null) {
        request.fields['id_tim'] = idTim;
      }

      request.fields['id_user'] = idUser;
      request.fields['id_sekolah'] = idSchool;
      request.fields['id_cabor'] = idCabor;
      request.fields['nama_team'] = namaTeam;
      request.fields['pembina'] = pembina;
      request.fields['pelatih'] = pelatih;
      request.fields['asisten_pelatih'] = asistenPelatih;
      request.fields['team_medis'] = teamMedis;
      request.fields['kordinator_supporter'] = kordinatorSupporter;
      request.fields['team_type'] = teamType;

      final result = await request.send();

      if (result.statusCode == 200) {
        final Map<String, dynamic> response =
            jsonDecode(await result.stream.bytesToString());
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          returnValue = ApiReturnValue(
              data: Tim.fromMap(apiResponse.response as Map<String, dynamic>),
              message: apiResponse.message);
        } else {
          returnValue = ApiReturnValue(message: apiResponse.message);
        }
      } else {
        returnValue = ApiReturnValue(message: result.reasonPhrase);
      }

      return returnValue;
    } on SocketException {
      return const ApiReturnValue(message: "Tidak Ada Koneksi!");
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<List<Tim>>> getIDTim(
      {required String idUser, required String idSekolah}) async {
    late ApiReturnValue<List<Tim>> returnValue;

    try {
      final result =
          await _client.post(Uri.parse(getIdTeamUrl), body: {
        'id_user': idUser.trim(),
        'id_sekolah': idSekolah.trim(),
      });

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          final data = (apiResponse.response as List)
              .map((e) => Tim.fromMap(e))
              .toList();

          returnValue =
              ApiReturnValue(data: data, message: apiResponse.message);
        } else {
          returnValue = ApiReturnValue(message: apiResponse.message);
        }
      } else if (result.statusCode == 404) {
        returnValue = const ApiReturnValue(message: "Resource not found");
      } else {
        returnValue = const ApiReturnValue(message: "Something error");
      }

      return returnValue;
    } on SocketException {
      return const ApiReturnValue(message: "Tidak Ada Koneksi!");
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }
}
