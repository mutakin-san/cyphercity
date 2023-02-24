import 'dart:convert';
import 'dart:io';

import 'package:cyphercity/utilities/config.dart';
import 'package:http/http.dart';

import '../api_return_value.dart';

class AboutServices {
  static final Client _client = Client();

  Future<ApiReturnValue<Map<String, String>>> getAboutText() async {
    late ApiReturnValue<Map<String, String>> returnValue;

    try {
      final result = await _client.get(Uri.parse(getAboutTextUrl));

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        returnValue = ApiReturnValue(data: (Map.from(response)));
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
