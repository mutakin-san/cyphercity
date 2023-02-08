import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../core/repos/repositories.dart';
import '../models/user.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;

  UserBloc(this._repository) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      final isLogin = await _repository.isLogin;
      final loginDetails = await _repository.loginDetails;
      if (isLogin && loginDetails != null) {
        emit(UserAuthenticated(loginDetails));
      } else {
        emit(UserNotAuthenticated());
      }
    });

    on<UserLogin>((event, emit) async {
      emit(UserLoading());
      final result = await _repository.login(
          username: event.username, password: event.password);

      if (result.data != null) {
        emit(UserAuthenticated(result.data!));
      } else {
        emit(UserError(result.message));
      }
    });

    on<UserRegister>((event, emit) async {
      emit(UserLoading());

      final result = await _repository.register(
          email: event.email,
          name: event.name,
          username: event.username,
          noHp: event.noHp,
          password: event.password,
          confirmPassword: event.confirmPassword,
          statusSekolah: event.statusSekolah);

      if (result.data != null) {
        emit(UserAuthenticated(result.data!));
      } else {
        emit(UserError(result.message));
      }
    });
    on<UserLogout>((event, emit) async {
      emit(UserLoading());

      await _repository.logout();
      emit(UserNotAuthenticated());
    });
  }
}
