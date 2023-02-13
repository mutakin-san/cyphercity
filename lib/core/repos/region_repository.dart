part of 'repositories.dart';

class RegionRepository {
  late final RegionServices _regionServices;

  RegionRepository() {
    _regionServices = RegionServices();
  }

  Future<ApiReturnValue<List<Regional>>> getAllRegional() =>
      _regionServices.getAllRegion();
}
