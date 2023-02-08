import 'package:cyphercity/core/network/api_return_value.dart';
import 'package:cyphercity/models/cabor.dart';
import 'package:cyphercity/models/event.dart';
import 'package:cyphercity/models/tim.dart';
import 'package:cyphercity/models/user.dart';
import 'package:cyphercity/utilities/config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ApiServices apiServices;
  late http.Client client;

  setUp(() {
    client = MockClient();
    apiServices = ApiServices(client);
  });

  group('Cabang Olahraga', () {
    test('Get All Cabor Successfully', () async {
      const httpResponse = """{
          "code": 200,
          "status": "success",
          "response": [
              {
                  "id": "1",
                  "nama_cabor": "Futsal Team",
                  "gambar": "710a8db7e261e354eb184d83e5a6cc76.jpg"
              },
              {
                  "id": "2",
                  "nama_cabor": "Vollyball Team",
                  "gambar": "dc744a5a337d88ee66e30e15ef6d1ac7.png"
              },
              {
                  "id": "3",
                  "nama_cabor": "Basketball Team",
                  "gambar": "7654d207943327b400d3f08461290a60.png"
              }
          ]
      }""";

      final expectedResult = [
        const Cabor(
            id: "1",
            namaCabor: "Futsal Team",
            gambar: "710a8db7e261e354eb184d83e5a6cc76.jpg"),
        const Cabor(
            id: "2",
            namaCabor: "Vollyball Team",
            gambar: "dc744a5a337d88ee66e30e15ef6d1ac7.png"),
        const Cabor(
            id: "3",
            namaCabor: "Basketball Team",
            gambar: "7654d207943327b400d3f08461290a60.png")
      ];

      when(client.get(Uri.parse("$baseUrl/api/ws/getListCabor")))
          .thenAnswer((_) async => http.Response(httpResponse, 200));

      final result = await apiServices.getAllCabor();
      expect(result, isA<ApiReturnValue>());
      expect(result.data, expectedResult);
    });

    test('Get All Cabor Failed', () async {
      const httpResponse = """{
        "code": 404,
        "status": "error",
        "msg": "Resource not found"
    }""";

      when(client.get(Uri.parse("$baseUrl/api/ws/getListCabor")))
          .thenAnswer((_) async => http.Response(httpResponse, 200));

      final result = await apiServices.getAllCabor();
      expect(result, isA<ApiReturnValue>());
      expect(result.message, "Resource not found");
    });
  });

  group('Events', () {
    test('Get All Events Successfully', () async {
      const httpResponse = """{
          "code": 200,
          "status": "success",
          "response": [
              {
                  "id": "1",
                  "nama_event": "Futsal Competition Region Banjar",
                  "tanggal_start": "2023-01-01",
                  "tanggal_end": "2023-01-27",
                  "exp_reg": "2023-01-05",
                  "gambar": "",
                  "status": "1"
              }
          ]
      }
      """;

      final expectedResult = [
        Event(
            id: "1",
            namaEvent: "Futsal Competition Region Banjar",
            tanggalStart: DateTime.parse("2023-01-01"),
            tanggalEnd: DateTime.parse("2023-01-27"),
            expReg: DateTime.parse("2023-01-05"),
            gambar: "",
            status: "1")
      ];

      when(client.get(Uri.parse("$baseUrl/api/ws/getListEvent")))
          .thenAnswer((_) async => http.Response(httpResponse, 200));

      final result = await apiServices.getAllEvents();

      expect(result, isA<ApiReturnValue>());
      expect(result.data, expectedResult);
    });

    test('Get All Events Failed', () async {
      const httpResponse = """{
        "code": 404,
        "status": "error",
        "msg": "Resource not found"
    }
    """;

      when(client.get(Uri.parse("$baseUrl/api/ws/getListEvent")))
          .thenAnswer((_) async => http.Response(httpResponse, 200));

      final result = await apiServices.getAllEvents();

      expect(result, isA<ApiReturnValue>());
      expect(result.message, "Resource not found");
    });
  });

  group('Register', () {
    test('Register new user success', () async {
      const httpResponse = """{
        "code": 200,
        "status": "success",
        "msg": "Registrasi Berhasil!",
        "response": {"user_id":"1","username":"ilham","nama":"Ilham Ependi","level":"0","sess_id":true}
    }""";

      when(client.post(Uri.parse("$baseUrl/api/login/create_user"), body: {
        'email': "mutakin.email@gmail.com",
        'username': "mutakin11",
        'nama': "Mutakin",
        'no_hp': "0",
        'password': "mutakin123",
        'password_ulang': "mutakin123",
        'status_sekolah': "0",
      })).thenAnswer((_) async => http.Response(httpResponse, 200));

      final result = await apiServices.register(
          username: "mutakin11",
          name: "Mutakin",
          email: "mutakin.email@gmail.com",
          password: "mutakin123",
          noHp: "0",
          confirmPassword: "mutakin123");

      expect(result, isA<ApiReturnValue>());
      expect(result.data, isA<User>());
      expect(result.message, "Registrasi Berhasil!");
    });

    test('Register new user with missing arguments', () async {
      const httpResponse = """{
        "code": 401,
        "status": "error",
        "msg": "Data Tidak Lengkap!"
    }""";

      when(client.post(Uri.parse("$baseUrl/api/login/create_user"), body: {
        'email': "mutakin.email@gmail.com",
        'username': "mutakin11",
        'nama': "Mutakin",
        'no_hp': "0",
        'password': "mutakin123",
        'password_ulang': "mutakin123",
        'status_sekolah': "1",
      })).thenAnswer((_) async => http.Response(httpResponse, 200));

      final result = await apiServices.register(
          username: "mutakin11",
          name: "Mutakin",
          email: "mutakin.email@gmail.com",
          password: "mutakin123",
          confirmPassword: "mutakin123",
          noHp: "0",
          statusSekolah: 1);

      expect(result, isA<ApiReturnValue>());
      expect(result.message, "Data Tidak Lengkap!");
    });
  });

  group('Login', () {
    test('Login user success', () async {
      const httpResponse = """{
        "code": 200,
        "status": "success",
        "msg": "Login Berhasil!",
        "response": {"user_id":"1","username":"ilham","nama":"Ilham Ependi","level":"0","sess_id":true}
        }""";

      when(client.post(Uri.parse("$baseUrl/api/login/auth_log"), body: {
        'username': "mutakin",
        'password': "mutakin123",
      })).thenAnswer((_) async => http.Response(httpResponse, 200));

      final result =
          await apiServices.login(username: "mutakin", password: "mutakin123");

      expect(result, isA<ApiReturnValue>());
      expect(result.message, "Login Berhasil!");
      expect(result.data, isA<User>());
    });

    test('Login user with missing arguments', () async {
      const httpResponse = """{
        "code": 401,
        "status": "error",
        "msg": "Data Tidak Lengkap!"
    }""";

      when(client.post(Uri.parse("$baseUrl/api/login/auth_log"), body: {
        'username': "mutakin.email@gmail.com",
        'password': "mutakin123",
      })).thenAnswer((_) async => http.Response(httpResponse, 200));

      final result = await apiServices.login(
          username: "mutakin.email@gmail.com", password: "mutakin123");

      expect(result, isA<ApiReturnValue>());
      expect(result.message, "Data Tidak Lengkap!");
    });
  });

  test('Test Get ID Tim', () async {
    const httpResponse =
        """{"code":200,"status":"success","response":[{"id": "1", "id_user":"1","id_sekolah":"1","id_cabor":"1","nama_team":"Nedascis Futsal A","pembina":"Ilham","pelatih":"Ilham","asisten_pelatih":"Ilham","team_medis":"Ilham","kordinator_supporter":"Ilham","0":true}]}""";

    const expectedResult = [
      Tim(
          id: "1",
          idUser: "1",
          idSekolah: "1",
          idCabor: "1",
          namaTeam: "Nedascis Futsal A",
          pembina: "Ilham",
          pelatih: "Ilham",
          asistenPelatih: "Ilham",
          teamMedis: "Ilham",
          kordinatorSupporter: "Ilham")
    ];

    when(client.post(Uri.parse("$baseUrl/api/home/getIdTim"),
            body: {'id_user': "1", 'id_sekolah': "1"}))
        .thenAnswer((_) async => http.Response(httpResponse, 200));

    final result = await apiServices.getIDTim(idUser: "1", idSekolah: "1");

    expect(result, isA<ApiReturnValue>());
    expect(result.data, isA<List<Tim>>());
    expect(result.data, expectedResult);
  });

  test('Test If Get ID Tim Return unsuccessfully response', () async {
    const httpResponse = """{"code": 200,"status":"success","response": []}""";

    when(client.post(Uri.parse("$baseUrl/api/home/getIdTim"),
            body: {'id_user': "1", 'id_sekolah': "1"}))
        .thenAnswer((_) async => http.Response(httpResponse, 200));

    final result = await apiServices.getIDTim(idUser: "1", idSekolah: "1");

    expect(result, isA<ApiReturnValue>());
    expect(result.data, isA<List>());
  });
}
