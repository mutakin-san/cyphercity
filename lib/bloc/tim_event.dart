part of 'tim_bloc.dart';


abstract class TimEvent extends Equatable{
  @override
  List<Object?> get props => [];
}


class LoadTim extends TimEvent {
  final String idUser;final String idSchool;

  LoadTim(this.idUser, this.idSchool);

  @override
  List<Object?> get props => [idUser, idSchool];
}