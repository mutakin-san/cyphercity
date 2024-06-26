import 'package:bloc/bloc.dart';
import '../core/repos/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../models/player.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final TeamRepository _teamRepository;

  PlayerBloc(this._teamRepository) : super(PlayerInitial()) {
    on<LoadPlayer>((event, emit) async {
      emit(PlayerLoading());
      final result = await _teamRepository.getListPlayer(
          idUser: event.idUser, idTim: event.idTim);
      if (result.data != null) {
        emit(PlayerLoaded(result.data!));
      } else {
        emit(PlayerFailed(result.message ?? "Something error"));
      }
    });

    on<AddNewPlayer>((event, emit) async {
      emit(PlayerLoading());
      final result = await _teamRepository.createPlayer(
          idUser: event.idUser,
          idTim: event.idTim,
          playerName: event.playerName,
          tglLahir: event.tglLahir,
          nisn: event.nisn,
          posisi: event.posisi,
          noPunggung: event.noPunggung,
          foto: event.foto,
          aktaLahir: event.aktaLahir,
          kk: event.kk);

      if (result.data != null) {
        emit(PlayerCreated(player: result.data!, message: result.message));
      } else {
        emit(PlayerFailed(result.message ?? "Something error"));
      }
    });

    on<UpdatePlayer>((event, emit) async {
      emit(PlayerLoading());
      final result = await _teamRepository.createPlayer(
          idPlayer: event.idPlayer,
          idUser: event.idUser,
          idTim: event.idTim,
          playerName: event.playerName,
          tglLahir: event.tglLahir,
          nisn: event.nisn,
          posisi: event.posisi,
          noPunggung: event.noPunggung,
          foto: event.foto,
          aktaLahir: event.aktaLahir,
          kk: event.kk);

      if (result.data != null) {
        emit(PlayerCreated(player: result.data!, message: result.message));
      } else {
        emit(PlayerFailed(result.message ?? "Something error"));
      }
    });

    on<DeletePlayer>((event, emit) async {
      emit(PlayerLoading());
      final result =
          await _teamRepository.deletePlayer(playerId: event.playerId);

      if (result.data != null && result.data!) {
        add(LoadPlayer(event.userId, event.timId));
      } else {
        emit(PlayerFailed(result.message ?? "Something error"));
      }
    });
  }
}
