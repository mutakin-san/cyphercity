part of 'repositories.dart';

class NewsRepository {
  late final NewsServices _caborServices;

  NewsRepository() {
    _caborServices = NewsServices();
  }

  Future<ApiReturnValue<List<News>>> getAllNews() =>
      _caborServices.getAllNews();
}
