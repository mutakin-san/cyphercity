import 'dart:convert';

import '../models/school.dart';
import '../models/user.dart';
import '../utilities/config.dart';
import '../models/api_response.dart';
import '../services/api_return_value.dart';
import 'package:image_picker/image_picker.dart';

import '../models/cabor.dart';
import 'package:http/http.dart' as http;

import '../models/event.dart';
import '../models/tim.dart';

class ApiServices {
  final http.Client _client;

  ApiServices(this._client);

  Future<ApiReturnValue<List<Cabor>>> getAllCabor() async {
    late ApiReturnValue<List<Cabor>> returnValue;

    try {
      final result =
          await _client.get(Uri.parse("$baseUrl/api/ws/getListCabor"));

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          final listCabor = (apiResponse.response as List)
              .map((e) => Cabor.fromMap(e))
              .toList();
          returnValue = ApiReturnValue(data: listCabor);
        } else {
          returnValue = ApiReturnValue(message: apiResponse.message);
        }
      } else if (result.statusCode == 404) {
        returnValue = const ApiReturnValue(message: "Resource not found");
      } else {
        returnValue = const ApiReturnValue(message: "Something error");
      }

      return returnValue;
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<List<Event>>> getAllEvents() async {
    late ApiReturnValue<List<Event>> returnValue;

    try {
      final result =
          await _client.get(Uri.parse("$baseUrl/api/ws/getListEvent"));

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          final listEvent = (apiResponse.response as List)
              .map((e) => Event.fromMap(e))
              .toList();
          returnValue = ApiReturnValue(data: listEvent);
        } else {
          returnValue = ApiReturnValue(message: apiResponse.message);
        }
      } else if (result.statusCode == 404) {
        returnValue = const ApiReturnValue(message: "Resource not found");
      } else {
        returnValue = const ApiReturnValue(message: "Something error");
      }

      return returnValue;
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<User>> register(
      {required String email,
      required String name,
      required String username,
      required String noHp,
      required String password,
      required String confirmPassword,
      int? statusSekolah = 0}) async {
    late ApiReturnValue<User> returnValue;

    try {
      final result = await _client
          .post(Uri.parse("$baseUrl/api/login/create_user"), body: {
        'email': email.trim(),
        'username': username.trim(),
        'nama': name.trim(),
        'no_hp': noHp.trim(),
        'password': password.trim(),
        'password_ulang': confirmPassword.trim(),
        'status_sekolah': statusSekolah.toString(),
      });

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          returnValue = ApiReturnValue(
              data: User.fromJson(apiResponse.response as Map<String, dynamic>),
              message: apiResponse.message);
        } else {
          returnValue = ApiReturnValue(message: apiResponse.message);
        }
      } else if (result.statusCode == 404) {
        returnValue = const ApiReturnValue(message: "Resource not found");
      } else {
        returnValue = const ApiReturnValue(message: "Something error");
      }

      return returnValue;
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<User>> login(
      {required String username, required String password}) async {
    late ApiReturnValue<User> returnValue;

    try {
      final result =
          await _client.post(Uri.parse("$baseUrl/api/login/auth_log"), body: {
        'username': username.trim(),
        'password': password.trim(),
      });

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          returnValue = ApiReturnValue(
              data: User.fromJson(apiResponse.response as Map<String, dynamic>),
              message: apiResponse.message);
        } else {
          returnValue = ApiReturnValue(message: apiResponse.message);
        }
      } else if (result.statusCode == 404) {
        returnValue = const ApiReturnValue(message: "Resource not found");
      } else {
        returnValue = const ApiReturnValue(message: "Something error");
      }

      return returnValue;
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<School>> getIDSekolah({required String idUser}) async {
    late ApiReturnValue<School> returnValue;

    try {
      final result = await _client
          .get(Uri.parse("$baseUrl/api/ws/getIdSekolah/$idUser"));

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
      } else if (result.statusCode == 404) {
        returnValue = const ApiReturnValue(message: "Resource not found");
      } else {
        returnValue = const ApiReturnValue(message: "Something error");
      }

      return returnValue;
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<List<Tim>>> getIDTim(
      {required String idUser, required String idSekolah}) async {
    late ApiReturnValue<List<Tim>> returnValue;

    try {
      final result =
          await _client.post(Uri.parse("$baseUrl/api/home/getIdTim"), body: {
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
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<List<Tim>>> getListTim(
      {required String idUser, required String idSekolah}) async {
    late ApiReturnValue<List<Tim>> returnValue;

    try {
      final result =
          await _client.post(Uri.parse("$baseUrl/api/ws/getListTim"), body: {
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
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<ApiResponse>> registerEvent(
      {required String idEvent, required String idUser, required String idSekolah, required String idTim}) async {
    late ApiReturnValue<ApiResponse> returnValue;

    try {
      final result =
          await _client.post(Uri.parse("$baseUrl/api/ws/RegisEvent"), body: {
        'id_event': idEvent.trim(),
        'id_user': idUser.trim(),
        'id_sekolah': idSekolah.trim(),
        'id_tim': idTim.trim(),
      });

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          returnValue =
              ApiReturnValue(data: apiResponse, message: apiResponse.message);
        } else {
          returnValue = ApiReturnValue(message: apiResponse.message);
        }
      } else if (result.statusCode == 404) {
        returnValue = const ApiReturnValue(message: "Resource not found");
      } else {
        returnValue = const ApiReturnValue(message: "Something error");
      }

      return returnValue;
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<bool>> editBiodataSekolah(
      {required String? kode, required String idUser, required String namaSekolah, required String npsn, required String biodata, XFile? image}) async {
    late ApiReturnValue<bool> returnValue;

    try {



      final request = http.MultipartRequest("POST", Uri.parse("$baseUrl/api/ws/EditSekolah"));

      request.headers['content-type'] = 'multipart/form-data';

      if(image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('file', image.path)
        );
      }


      if(kode != null) {
        request
        .fields['kode'] = kode;
      }

      request.fields['id_user'] = idUser;
      request.fields['nama_sekolah'] = namaSekolah;
      request.fields['npsn'] = npsn;
      request.fields['biodata'] = biodata;



      final result = await request.send();

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(await result.stream.bytesToString());
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          returnValue =
              ApiReturnValue(data: true, message: apiResponse.message);
        } else {
          returnValue = ApiReturnValue(message: apiResponse.message);
        }
      } else if (result.statusCode == 404) {
        returnValue = const ApiReturnValue(message: "Resource not found");
      } else {
        returnValue = const ApiReturnValue(message: "Something error");
      }

      return returnValue;
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }



}
