part of 'school_cubit.dart';

abstract class SchoolState extends Equatable {
  const SchoolState();

  @override
  List<Object?> get props => [];
}

class SchoolInitial extends SchoolState {}

class SchoolLoading extends SchoolState {}

class SchoolLoaded extends SchoolState {
  final School data;

  const SchoolLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class SchoolFailed extends SchoolState {
  final String message;

  const SchoolFailed(this.message);

  @override
  List<Object?> get props => [message];
}
