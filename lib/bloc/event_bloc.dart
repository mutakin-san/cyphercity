import 'package:bloc/bloc.dart';
import 'package:cyphercity/core/repos/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../models/event.dart';
import '../models/reg_event.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository _eventRepository;
  EventBloc(this._eventRepository) : super(EventInitial()) {
    on<GetAllEvent>((event, emit) async {
      emit(EventLoading());
      final result = await _eventRepository.getAllEvents(event.userId);

      if (result.data != null) {
        if (result.data!.isEmpty) {
          emit(const EventLoaded([]));
        } else {
          emit(EventLoaded(result.data!));
        }
      } else {
        emit(EventFailed(result.message ?? "Tidak ditemukan"));
      }
    });

    on<GetRegisteredEvent>((event, emit) async {
      emit(EventLoading());
      final result = await _eventRepository.getRegisteredEvents(
          event.userId, event.schoolId);

      if (result.data != null) {
        if (result.data!.isEmpty) {
          emit(const EventLoaded([]));
        } else {
          emit(RegisteredEventLoaded(result.data!));
        }
      } else {
        emit(EventFailed(result.message ?? "Tidak ditemukan"));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(EventLoading());

      final result = await _eventRepository.registerEvent(
          idEvent: event.idEvent,
          idUser: event.idUser,
          idSekolah: event.idSekolah,
          idCabor: event.idCabor,
          idTim: event.idTim);

      if (result.data != null && result.data!.status == 'success') {
        emit(RegisterEventSucces());
      } else {
        emit(EventFailed(result.message ?? "Tidak ditemukan"));
      }
    });

    on<ConfirmPaymentEvent>((event, emit) async {
      emit(EventLoading());

      final result = await _eventRepository.confirmPaymentEvent(
          idReg: event.idReg,
          idEvent: event.idEvent,
          idUser: event.idUser,
          idSekolah: event.idSekolah,
          idCabor: event.idCabor,
          idTim: event.idTim,
          buktiBayar: event.buktiBayar);

      if (result.data != null && result.data!.status == 'success') {
        emit(ConfirmPaymentSucces());
      } else {
        emit(EventFailed(result.message ?? "Tidak ditemukan"));
      }
    });
  }
}
