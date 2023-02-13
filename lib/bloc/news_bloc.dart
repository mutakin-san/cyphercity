import 'package:bloc/bloc.dart';
import 'package:cyphercity/core/repos/repositories.dart';
import 'package:cyphercity/models/news.dart';
import 'package:equatable/equatable.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;
  NewsBloc(this._newsRepository) : super(NewsInitial()) {
    on<LoadNews>((event, emit) async {
      emit(NewsLoading());

      final result = await _newsRepository.getAllNews();

      if (result.data != null) {
        emit(NewsLoaded(result.data!));
      } else {
        emit(NewsFailed(result.message ?? "Something error"));
      }
    });
  }
}
