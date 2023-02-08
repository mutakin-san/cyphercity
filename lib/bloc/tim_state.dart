part of 'tim_bloc.dart';

abstract class TimState extends Equatable {
  const TimState();

  @override
  List<Object> get props => [];
}

class TimInitial extends TimState {}

class TimLoaded extends TimState {
  final List<Tim> data;

  const TimLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class TimCreated extends TimState {
  final Tim tim;

  const TimCreated(this.tim);

  @override
  List<Object> get props => [tim];
}

class TimFailed extends TimState {
  final String message;

  const TimFailed(this.message);

  @override
  List<Object> get props => [message];
}

class TimLoading extends TimState {}
