import 'dart:convert';

import 'package:cyphercity/consts/config.dart';
import 'package:cyphercity/services/api_return_value.dart';
import 'package:flutter/foundation.dart';

import '../models/cabor.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<ApiReturnValue<List<Cabor>>> getAllCabor() async {
    late ApiReturnValue<List<Cabor>> returnValue;

    final result =
        await http.Client().get(Uri.parse("$baseUrl/api/home/getCabor"));

    try {
      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        debugPrint("$response");
        if (response['status'] == 'success' && response['code'] == 200) {
          final listCabor = (response['response'] as List)
              .map((e) => Cabor.fromMap(e))
              .toList();
          returnValue = ApiReturnValue(data: listCabor);
        } else {
          returnValue = ApiReturnValue(message: response['msg']);
        }
      }

      return returnValue;
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }
}
