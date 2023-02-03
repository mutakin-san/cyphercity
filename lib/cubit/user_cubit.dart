import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../services/login_pref_service.dart';
import '../services/api_services.dart';
import '../models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> loadUser() async {

    emit(UserLoading());

    final user = await LoginPrefService.loginDetails;

    if (user != null) {
      emit(UserLoaded(user));
    } else {
      emit(const UserError('User not found'));
    }
  }

  Future<void> login(
      {required String username, required String password}) async {
    final apiServices = ApiServices(http.Client());

    emit(UserLoading());

    final result =
        await apiServices.login(username: username, password: password);

    if (result.data != null) {
      try {
        if (await LoginPrefService.setLogin(true) &&
            await LoginPrefService.setLoginDetails(result.data!.toJson())) {
          emit(UserLoaded(result.data!));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    } else {
      emit(UserError(result.message!));
    }
  }

  Future<void> register(
      {required String email,
      required String name,
      required String username,
      required String noHp,
      required String password,
      required String confirmPassword,
      int? statusSekolah}) async {
    final apiServices = ApiServices(http.Client());

    emit(UserLoading());

    final result = await apiServices.register(
      email: email,
      username: username,
      name: name,
      password: password,
      confirmPassword: confirmPassword,
      noHp: noHp,
      statusSekolah: statusSekolah,
    );

    if (result.data != null) {
      try {
        if (await LoginPrefService.setLogin(true) &&
            await LoginPrefService.setLoginDetails(result.data!.toJson())) {
          emit(UserLoaded(result.data!));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    } else {
      emit(UserError(result.message!));
    }
  }
}
