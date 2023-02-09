part of 'news.dart';

class NewsServices {
  static final Client _client = Client();

  Future<ApiReturnValue<List<News>>> getAllNews() async {
    late ApiReturnValue<List<News>> returnValue;

    try {
      final result =
          await _client.get(Uri.parse("$baseUrl/api/ws/getListNews"));

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          final listCabor = (apiResponse.response as List)
              .map((e) => News.fromMap(e))
              .toList();
          returnValue = ApiReturnValue(data: listCabor);
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
