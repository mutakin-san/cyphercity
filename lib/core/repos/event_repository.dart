part of 'repositories.dart';

class EventRepository {
  late final EventServices _eventServices;

  EventRepository() {
    _eventServices = EventServices();
  }

  Future<ApiReturnValue<List<Event>>> getAllEvents() async {
    return await _eventServices.getAllEvents();
  }

  Future<ApiReturnValue<ApiResponse>> registerEvent(
          {required String idEvent,
          required String idUser,
          required String idSekolah,
          required String idTim}) =>
      _eventServices.registerEvent(
          idEvent: idEvent, idUser: idUser, idSekolah: idSekolah, idTim: idTim);
}