part of 'team.dart';

class TeamServices {

  static final Client _client = Client();

  
  Future<ApiReturnValue<List<Tim>>> getListTim(
      {required String idUser, required String idSekolah}) async {
    late ApiReturnValue<List<Tim>> returnValue;

    try {
      final result =
          await _client.post(Uri.parse(getTeamUrl), body: {
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

              print(data.toString());

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
}