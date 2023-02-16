part of 'school.dart';

class SchoolServices {
  static final Client _client = Client();

  Future<ApiReturnValue<School?>> getDetailSchool(
      {required String idUser}) async {
    late ApiReturnValue<School?> returnValue;

    try {
      final result = await _client.get(Uri.parse("$getSchoolIdUrl/$idUser"));

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          if (apiResponse.response != null) {
            School data =
                School.fromMap(apiResponse.response as Map<String, dynamic>);
            returnValue = ApiReturnValue(data: data);
          } else {
            returnValue = const ApiReturnValue(message: "Data Not Found");
          }
        } else {
          returnValue = const ApiReturnValue(message: "Unexpected Error");
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

  Future<ApiReturnValue<bool>> editSchoolBiodata(
      {required String? kode,
      required String idUser,
      required String idRegion,
      required String namaSekolah,
      required String npsn,
      required String biodata,
      XFile? image}) async {
    late ApiReturnValue<bool> returnValue;

    try {
      final request = MultipartRequest("POST", Uri.parse(editBiodataUrl));

      request.headers['content-type'] = 'multipart/form-data';

      if (image != null) {
        request.files.add(await MultipartFile.fromPath('file', image.path));
      }

      if (kode != null) {
        request.fields['kode'] = kode;
      }

      request.fields['id_user'] = idUser;
      request.fields['id_region'] = idRegion;
      request.fields['nama_sekolah'] = namaSekolah;
      request.fields['npsn'] = npsn;
      request.fields['biodata'] = biodata;

      final result = await request.send();

      if (result.statusCode == 200) {
        final Map<String, dynamic> response =
            jsonDecode(await result.stream.bytesToString());
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          returnValue =
              ApiReturnValue(data: true, message: apiResponse.message);
        } else {
          returnValue =
              ApiReturnValue(data: false, message: apiResponse.message);
        }
      } else {
        returnValue = ApiReturnValue(data: false, message: result.reasonPhrase);
        if (kDebugMode) {
          print(await result.stream.bytesToString());
        }
      }

      return returnValue;
    } on SocketException {
      return const ApiReturnValue(message: "Tidak Ada Koneksi!");
    } catch (e) {
      return ApiReturnValue(data: false, message: e.toString());
    }
  }

  Future<ApiReturnValue<bool>> uploadLogoSekolah(
      {required String schoolId,
      required String userId,
      required XFile image}) async {
    final request = MultipartRequest("POST", Uri.parse(uploadLogoUrl));

    request.headers['content-type'] = 'multipart/form-data';

    request.files.add(await MultipartFile.fromPath('file', image.path));

    request.fields['kode'] = schoolId;
    request.fields['id_user'] = userId;

    try {
      final result = await request.send();

      if (result.statusCode == 200) {
        final Map<String, dynamic> response =
            jsonDecode(await result.stream.bytesToString());
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          return ApiReturnValue(data: true, message: apiResponse.message);
        } else {
          return ApiReturnValue(data: false, message: apiResponse.message);
        }
      } else {
        return ApiReturnValue(data: false, message: result.reasonPhrase);
      }
    } on SocketException {
      return const ApiReturnValue(message: "Tidak Ada Koneksi!");
    } catch (e) {
      return ApiReturnValue(data: false, message: e.toString());
    }
  }
}
