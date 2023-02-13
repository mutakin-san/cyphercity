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
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<ApiResponse>> registerEvent(
      {required String idEvent,
      required String idUser,
      required String idSekolah,
      required String idTim}) async {
    late ApiReturnValue<ApiResponse> returnValue;

    try {
      final result = await _client.post(Uri.parse(registerEventUrl), body: {
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
      } else {
        returnValue = ApiReturnValue(message: result.reasonPhrase);
      }

      return returnValue;
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }
}
