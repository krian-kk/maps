import 'package:maps/features/explore_map/domain/entities/location_model.dart';
import 'package:maps/features/explore_map/domain/usecases/get_location_usecase.dart';

class LocationRepository {
  Future<List<LocationEntity>> fetchLocations() {
    // Mock implementation
    return GetLocationsUseCase().call();
  }
}
