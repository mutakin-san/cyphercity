part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPlayer extends PlayerEvent {
  final String idUser;
  final String idTim;

  LoadPlayer(this.idUser, this.idTim);

  @override
  List<Object?> get props => [idUser, idTim];
}

class AddNewPlayer extends PlayerEvent {
  final String idUser;
  final String idTim;
  final String playerName;
  final String tglLahir;
  final String nisn;
  final String posisi;
  final String noPunggung;
  final XFile? foto;
  final XFile? aktaLahir;
  final XFile? kk;

  AddNewPlayer({
    required this.idUser,
    required this.idTim,
    required this.playerName,
    required this.tglLahir,
    required this.nisn,
    required this.posisi,
    required this.noPunggung,
    this.foto,
    this.aktaLahir,
    this.kk,
  });

  @override
  List<Object?> get props => [
        idUser,
        idTim,
        playerName,
        tglLahir,
        nisn,
        posisi,
        noPunggung,
        foto,
        aktaLahir,
        kk,
      ];
}

class UpdatePlayer extends PlayerEvent {
  final String idPlayer;
  final String idUser;
  final String idTim;
  final String playerName;
  final String tglLahir;
  final String nisn;
  final String posisi;
  final String noPunggung;
  final XFile? foto;
  final XFile? aktaLahir;
  final XFile? kk;

  UpdatePlayer({
    required this.idPlayer,
    required this.idUser,
    required this.idTim,
    required this.playerName,
    required this.tglLahir,
    required this.nisn,
    required this.posisi,
    required this.noPunggung,
    this.foto,
    this.aktaLahir,
    this.kk,
  });

  @override
  List<Object?> get props => [
        idPlayer,
        idUser,
        idTim,
        playerName,
        tglLahir,
        nisn,
        posisi,
        noPunggung,
        foto,
        aktaLahir,
        kk,
      ];
}

class DeletePlayer extends PlayerEvent {
  final String playerId;
  final String userId;
  final String timId;

  DeletePlayer(
      {required this.userId, required this.timId, required this.playerId});
}
