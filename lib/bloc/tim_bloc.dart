import 'package:bloc/bloc.dart';
import '../core/repos/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../models/tim.dart';

part 'tim_event.dart';
part 'tim_state.dart';

class TimBloc extends Bloc<TimEvent, TimState> {
  final TeamRepository _teamRepository;

  TimBloc(this._teamRepository) : super(TimInitial()) {
    on<LoadTim>((event, emit) async {
      emit(TimLoading());
      final result = await _teamRepository.getListTim(
          idUser: event.idUser,
          idSekolah: event.idSchool,
          idCabor: event.idCabor);
      if (result.data != null) {
        emit(TimLoaded(result.data!));
      } else {
        emit(TimFailed(result.message ?? "Something error"));
      }
    });

    on<AddNewTeam>((event, emit) async {
      emit(TimLoading());
      final result = await _teamRepository.createTeam(
          idUser: event.idUser,
          idSchool: event.idSchool,
          idCabor: event.idCabor,
          namaTeam: event.namaTeam,
          pembina: event.pembina,
          pelatih: event.pelatih,
          asistenPelatih: event.asistenPelatih,
          teamMedis: event.teamMedis,
          kordinatorSupporter: event.kordinatorSupporter,
          teamType: event.teamType,
          skkpImage: event.skkpImage);

      if (result.data != null) {
        emit(TimCreated(result.data!));
      } else {
        emit(TimFailed(result.message ?? "Something error"));
      }
    });

    on<UpdateLogo>((event, emit) async {
      final previousState = (state as TimLoaded)
          .data
          .singleWhere((element) => element.id == event.teamId);
      emit(TimLoading());
      final result =
          await _teamRepository.updateLogoTeam(event.teamId, event.image);

      if (result.data != null) {
        emit(TimLogoUpdated(result.data!, result.message ?? ""));
        add(LoadTim(previousState.idUser, previousState.idSekolah,
            previousState.idCabor));
      } else {
        emit(TimFailed(result.message ?? "Something error"));
      }
    });
  }
}
