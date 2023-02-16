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
        } else if (apiResponse.status == 'failed' && apiResponse.code == 201) {
          returnValue = ApiReturnValue(data: [], message: apiResponse.status);
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

  Future<ApiReturnValue<Player>> createPlayer({
    String? idPlayer,
    required String idUser,
    required String idTim,
    required String playerName,
    required String tglLahir,
    required String nisn,
    required String posisi,
    required String noPunggung,
    XFile? foto,
    XFile? aktaLahir,
    XFile? kk,
  }) async {
    late ApiReturnValue<Player> returnValue;

    try {
      final request = MultipartRequest("POST",
          Uri.parse(idPlayer != null ? updatePlayerUrl : createPlayerUrl));

      request.headers['content-type'] = 'multipart/form-data';

      if (foto != null) {
        request.files.add(await MultipartFile.fromPath('file[]', foto.path));
      }
      if (aktaLahir != null) {
        request.files
            .add(await MultipartFile.fromPath('file[]', aktaLahir.path));
      }
      if (kk != null) {
        request.files.add(await MultipartFile.fromPath('file[]', kk.path));
      }

      if (idPlayer != null) {
        request.fields['id'] = idPlayer;
      }

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
        if (kDebugMode) {
          print(response);
        }
        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.status == 'success' && apiResponse.code == 200) {
          returnValue = ApiReturnValue(
              data:
                  Player.fromMap(apiResponse.response as Map<String, dynamic>),
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
      if (kDebugMode) {
        print(e);
      }
      return ApiReturnValue(message: e.toString());
    }
  }

  Future<ApiReturnValue<bool>> deletePlayer({
    required String playerId,
  }) async {
    late ApiReturnValue<bool> returnValue;

    try {
      final result = await _client
          .post(Uri.parse(deletePlayerUrl), body: {"id": playerId});

      if (result.statusCode == 200) {
        returnValue = const ApiReturnValue(data: true);
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
