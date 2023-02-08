part of 'team.dart';

class PlayerServices {
  static final Client _client = Client();

  Future<ApiReturnValue<List<Player>>> getListPlayer(
      {required String idUser, required String idTim}) async {
    late ApiReturnValue<List<Player>> returnValue;

    try {
      final result = await _client.post(Uri.parse(getPlayersUrl), body: {
        'id_user': idUser.trim(),
        'id_tim': idTim.trim(),
      });

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          final data = (apiResponse.response as List)
              .map((e) => Player.fromMap(e))
              .toList();

          returnValue =
              ApiReturnValue(data: data, message: apiResponse.message);
        } else if(apiResponse.status == 'failed' && apiResponse.code == 201) {
          returnValue =
              ApiReturnValue(data: [], message: apiResponse.status);
        }
        else {
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

  Future<ApiReturnValue<Player>> createPlayer({
    required String idUser,
    required String idTim,
    required String playerName,
    required String tglLahir,
    required String nisn,
    required String posisi,
    required String noPunggung,
    required XFile foto,
    required XFile aktaLahir,
    required XFile kk,
  }) async {
    late ApiReturnValue<Player> returnValue;

    try {
      final request = MultipartRequest("POST", Uri.parse(createPlayerUrl));

      request.headers['content-type'] = 'multipart/form-data';

      request.files.addAll([
        await MultipartFile.fromPath('file1', foto.path),
        await MultipartFile.fromPath('file2', aktaLahir.path),
        await MultipartFile.fromPath('file3', kk.path)
      ]);

      request.fields['id_user'] = idUser;
      request.fields['id_tim'] = idTim;
      request.fields['nama_pemain'] = playerName;
      request.fields['tgl_lahir'] = tglLahir;
      request.fields['nisn'] = nisn;
      request.fields['posisi'] = posisi;
      request.fields['no_punggung'] = noPunggung;

      final result = await request.send();

      if (result.statusCode == 200) {
        final Map<String, dynamic> response =
            jsonDecode(await result.stream.bytesToString());
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          returnValue = ApiReturnValue(
              data: Player.fromMap(apiResponse.response as Map<String, dynamic>),
              message: apiResponse.message);
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