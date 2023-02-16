part of 'region.dart';

class RegionServices {
  static final Client _client = Client();

  Future<ApiReturnValue<List<Regional>>> getAllRegion() async {
    late ApiReturnValue<List<Regional>> returnValue;

    try {
      final result = await _client.get(Uri.parse(getRegionIdUrl));

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          final listRegion = (apiResponse.response as List)
              .map((e) => Regional.fromMap(e))
              .toList();
          returnValue = ApiReturnValue(data: listRegion);
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
