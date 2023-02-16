part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> events;

  const EventLoaded(this.events);

  @override
  List<Object> get props => [events];
}

class RegisteredEventLoaded extends EventState {
  final List<RegEvent> data;

  const RegisteredEventLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class RegisterEventSucces extends EventState {}

class ConfirmPaymentSucces extends EventState {}

class EventFailed extends EventState {
  final String error;
  const EventFailed(this.error);

  @override
  List<Object> get props => [error];
}
