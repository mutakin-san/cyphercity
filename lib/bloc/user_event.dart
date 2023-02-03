part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}


class UserLogin extends UserEvent {
  final String username;
  final String password;

  const UserLogin(this.username, this.password);
}


class UserRegister extends UserEvent {
  final String email;
  final String name;
  final String username;
  final String noHp;
  final String password;
  final String confirmPassword;
  final int? statusSekolah;

  const UserRegister({required this.email, required this.name, required this.username, required this.noHp, required this.password, required this.confirmPassword, this.statusSekolah});
}

class LoadUser extends UserEvent {}

class UserLogout extends UserEvent {}