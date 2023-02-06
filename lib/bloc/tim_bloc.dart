import 'package:bloc/bloc.dart';
import 'package:cyphercity/core/repos/repositories.dart';
import 'package:equatable/equatable.dart';
import '../models/tim.dart';

part 'tim_state.dart';
part 'tim_event.dart';

class TimBloc extends Bloc<TimEvent, TimState> {
  final TeamRepository _teamRepository;
  TimBloc(this._teamRepository) : super(TimInitial()) {

    on<LoadTim>((event, emit) async {
      final result =
          await _teamRepository.getListTim(idUser: event.idUser, idSekolah: event.idSchool);
      if (result.data != null) {
        emit(TimLoaded(result.data!));
      } else {
        emit(TimFailed(result.message ?? "Something error"));
      }
    });
  }
}
