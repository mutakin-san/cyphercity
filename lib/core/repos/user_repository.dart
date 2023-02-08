part of 'repositories.dart';

class UserRepository {
  final AuthServices _network = AuthServices();
  final AuthLocalPreferences _local = AuthLocalPreferences();

  Future<bool> get isLogin async => _local.isLogin;

  Future<User?> get loginDetails async => await _local.loginDetails;

  Future<bool> logout() async {
    try {
      await _local.setLogin(false);
      await _local.setLoginDetails(null);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<ApiReturnValue<User?>> getDetailUser({required String userId}) async {
    final result = await _network.getDetailUser(
      userId: userId,
    );

    return result;
  }

  Future<ApiReturnValue<User?>> register(
      {required String email,
      required String name,
      required String username,
      required String noHp,
      required String password,
      required String confirmPassword,
      int? statusSekolah = 0}) async {
    final result = await _network.register(
      email: email,
      name: name,
      username: username,
      noHp: noHp,
      password: password,
      confirmPassword: confirmPassword,
      statusSekolah: statusSekolah,
    );

    if (result.data != null) {
      await _local.setLogin(true);
      await _local.setLoginDetails(result.data?.toJson());
    }

    return result;
  }

  Future<ApiReturnValue<User?>> login(
      {required String username, required String password}) async {
    final result = await _network.login(username: username, password: password);

    if (result.data != null) {
      await _local.setLogin(true);
      await _local.setLoginDetails(result.data?.toJson());
    }

    return result;
  }
}
