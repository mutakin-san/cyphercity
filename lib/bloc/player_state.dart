part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class PlayerInitial extends PlayerState {}

class PlayerLoaded extends PlayerState {
  final List<Player> data;

  const PlayerLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class PlayerCreated extends PlayerState {
  final Player player;
  final String? message;

  const PlayerCreated({required this.player, this.message});

  @override
  List<Object> get props => [player];
}

class PlayerFailed extends PlayerState {
  final String message;

  const PlayerFailed(this.message);

  @override
  List<Object> get props => [message];
}

class PlayerLoading extends PlayerState {}
