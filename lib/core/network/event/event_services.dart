part of 'event.dart';

class EventServices {
  static final Client _client = Client();

  Future<ApiReturnValue<List<Event>>> getAllEvents(String userId) async {
    late ApiReturnValue<List<Event>> returnValue;

    try {
      final result = await _client.get(Uri.https(
          "sfc.webseitama.com", "/api/ws/getListEvent", {"id_user": userId}));

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
    } on SocketException {
      return const ApiReturnValue(message: "Tidak Ada Koneksi!");
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<ApiResponse>> registerEvent(
      {required String idEvent,
      required String idUser,
      required String idSekolah,
      required String idCabor,
      required String idTim}) async {
    late ApiReturnValue<ApiResponse> returnValue;

    try {
      final result = await _client.post(Uri.parse(registerEventUrl), body: {
        'id_event': idEvent.trim(),
        'id_user': idUser.trim(),
        'id_sekolah': idSekolah.trim(),
        'id_cabor': idCabor.trim(),
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

  Future<ApiReturnValue<ApiResponse>> confirmPaymentEvent({
    required String idReg,
    required String idEvent,
    required String idUser,
    required String idSekolah,
    required String idCabor,
    required String idTim,
    required XFile buktiBayar,
  }) async {
    late ApiReturnValue<ApiResponse> returnValue;

    try {
      final request =
          MultipartRequest("POST", Uri.parse(confirmPaymentEventUrl));

      request.headers['content-type'] = 'multipart/form-data';

      request.files.add(await MultipartFile.fromPath('file', buktiBayar.path));

      request.fields['id_reg'] = idReg.trim();
      request.fields['id_event'] = idEvent.trim();
      request.fields['id_user'] = idUser.trim();
      request.fields['id_sekolah'] = idSekolah.trim();
      request.fields['id_cabor'] = idCabor.trim();
      request.fields['id_tim'] = idTim.trim();

      final result = await request.send();

      if (result.statusCode == 200) {
        final Map<String, dynamic> response =
            jsonDecode(await result.stream.bytesToString());

        if (kDebugMode) {
          print(response);
        }
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          returnValue =
              ApiReturnValue(data: apiResponse, message: apiResponse.message);
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

  Future<ApiReturnValue<List<RegEvent>>> getRegisteredEvents(
      String userId, String schoolId) async {
    late ApiReturnValue<List<RegEvent>> returnValue;

    try {
      final result = await _client.post(Uri.parse(getRegisteredEventUrl),
          body: {"id_user": userId, "id_sekolah": schoolId});

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          final listEvent = (apiResponse.response as List)
              .map((e) => RegEvent.fromMap(e))
              .toList();
          returnValue = ApiReturnValue(data: listEvent);
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
}
