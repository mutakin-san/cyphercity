part of 'repositories.dart';

class CaborRepository {
  late final CaborServices _caborServices;

  CaborRepository() {
    _caborServices = CaborServices();
  }

  Future<ApiReturnValue<List<Cabor>>> getAllCabor() =>
      _caborServices.getAllCabor();
}
