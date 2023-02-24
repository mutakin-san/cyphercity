part of 'about_bloc.dart';

abstract class AboutState extends Equatable {
  const AboutState();

  @override
  List<Object> get props => [];
}

class AboutLoading extends AboutState {}

class AboutLoaded extends AboutState {
  final Map<String, String> about;
  const AboutLoaded(this.about);


  @override
  List<Object> get props => [about];
}

class AboutFailed extends AboutState {
  final String error;
  const AboutFailed(this.error);


  @override
  List<Object> get props => [error];
}
