part of 'tim_cubit.dart';

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

class TimFailed extends TimState {
  final String message;

  const TimFailed(this.message);

  @override
  List<Object> get props => [message];
}
