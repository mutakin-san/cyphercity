part of 'cabor.dart';

class CaborServices {
  static final Client _client = Client();

  Future<ApiReturnValue<List<Cabor>>> getAllCabor() async {
    late ApiReturnValue<List<Cabor>> returnValue;

    try {
      final result = await _client.get(Uri.parse(getCaborIdUrl));

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
}
