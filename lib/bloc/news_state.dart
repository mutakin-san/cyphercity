part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> data;

  const NewsLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class NewsFailed extends NewsState {
  final String error;

  const NewsFailed(this.error);

  @override
  List<Object> get props => [error];
}
