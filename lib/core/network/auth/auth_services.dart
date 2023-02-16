part of 'auth.dart';

class AuthServices {
  static final Client _client = Client();

  Future<ApiReturnValue<User?>> register(
      {required String email,
      required String name,
      required String username,
      required String noHp,
      required String idRegion,
      required String password,
      required String confirmPassword,
      int? statusSekolah = 0}) async {
    late ApiReturnValue<User?> returnValue;

    try {
      final body = {
        'email': email.trim(),
        'username': username.trim(),
        'nama': name.trim(),
        'no_hp': noHp.trim(),
        'id_region': idRegion.trim(),
        'password': password.trim(),
        'password_ulang': confirmPassword.trim(),
        'status_sekolah': statusSekolah.toString(),
      };

      final result = await _client.post(Uri.parse(registerUrl), body: body);

      if (result.statusCode == 200) {
        final Map<String, dynamic> response =
            jsonDecode(utf8.decode(result.bodyBytes));

        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' &&
            apiResponse.code == 200 &&
            apiResponse.response != null) {
          returnValue = ApiReturnValue(
            data: User.fromJson(apiResponse.response as Map<String, dynamic>),
            message: apiResponse.message,
          );
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

  Future<ApiReturnValue<User?>> login(
      {required String username, required String password}) async {
    late ApiReturnValue<User?> returnValue;

    try {
      final body = {
        'username': username.trim(),
        'password': password.trim(),
      };

      final result = await _client.post(Uri.parse(loginUrl), body: body);

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' &&
            apiResponse.code == 200 &&
            apiResponse.response != null) {
          returnValue = ApiReturnValue(
              data: User.fromJson(apiResponse.response as Map<String, dynamic>),
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

  Future<ApiReturnValue<UserProfile>> getDetailUser(
      {required String userId}) async {
    late ApiReturnValue<UserProfile> returnValue;

    try {
      final result = await _client.get(Uri.parse("$getUserIdUrl/$userId"));

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          if (apiResponse.response != null) {
            returnValue = ApiReturnValue(
                data: UserProfile.fromMap(
                    apiResponse.response as Map<String, dynamic>),
                message: apiResponse.message);
          } else {
            returnValue = const ApiReturnValue(message: "Data Not Found");
          }
        } else {
          returnValue = ApiReturnValue(message: result.reasonPhrase);
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
