part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class GetAllEvent extends EventEvent {
  final String userId;

  const GetAllEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class GetRegisteredEvent extends EventEvent {
  final String userId;
  final String schoolId;

  const GetRegisteredEvent({required this.userId, required this.schoolId});

  @override
  List<Object> get props => [userId, schoolId];
}

class RegisterEvent extends EventEvent {
  final String idEvent;
  final String idUser;
  final String idSekolah;
  final String idCabor;
  final String idTim;

  const RegisterEvent(
      {required this.idEvent,
      required this.idUser,
      required this.idSekolah,
      required this.idCabor,
      required this.idTim});

  @override
  List<Object> get props => [
        idEvent,
        idUser,
        idSekolah,
        idCabor,
        idTim,
      ];
}

class ConfirmPaymentEvent extends EventEvent {
  final String idReg;
  final String idEvent;
  final String idUser;
  final String idSekolah;
  final String idCabor;
  final String idTim;
  final XFile buktiBayar;

  const ConfirmPaymentEvent({
    required this.idReg,
    required this.idEvent,
    required this.idUser,
    required this.idSekolah,
    required this.idCabor,
    required this.idTim,
    required this.buktiBayar,
  });

  @override
  List<Object> get props => [
        idReg,
        idEvent,
        idUser,
        idSekolah,
        idCabor,
        idTim,
        buktiBayar,
      ];
}
