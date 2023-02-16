part of 'repositories.dart';

class EventRepository {
  late final EventServices _eventServices;

  EventRepository() {
    _eventServices = EventServices();
  }

  Future<ApiReturnValue<List<Event>>> getAllEvents(String userId) {
    return _eventServices.getAllEvents(userId);
  }

  Future<ApiReturnValue<List<RegEvent>>> getRegisteredEvents(
      String userId, String schoolId) async {
    return _eventServices.getRegisteredEvents(userId, schoolId);
  }

  Future<ApiReturnValue<ApiResponse>> registerEvent(
          {required String idEvent,
          required String idUser,
          required String idSekolah,
          required String idCabor,
          required String idTim}) =>
      _eventServices.registerEvent(
          idEvent: idEvent,
          idUser: idUser,
          idSekolah: idSekolah,
          idCabor: idCabor,
          idTim: idTim);

  Future<ApiReturnValue<ApiResponse>> confirmPaymentEvent({
    required String idReg,
    required String idEvent,
    required String idUser,
    required String idSekolah,
    required String idCabor,
    required String idTim,
    required XFile buktiBayar,
  }) =>
      _eventServices.confirmPaymentEvent(
        idReg: idReg,
        idEvent: idEvent,
        idUser: idUser,
        idSekolah: idSekolah,
        idCabor: idCabor,
        idTim: idTim,
        buktiBayar: buktiBayar,
      );
}
