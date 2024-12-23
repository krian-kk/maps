import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/features/explore_map/domain/entities/location_model.dart';

class GetLocationsUseCase {
  Future<List<LocationEntity>> call() async {
    // Simulate fetching locations (later connect to a data source).
    return [
      LocationEntity(
        id: '1',
        name: 'Cycle Pickup Point 1',
        category: 'Cycle',
        position: const LatLng(37.7749, -122.4194),
      ),
      LocationEntity(
        id: '2',
        name: 'Shopping Mall 1',
        category: 'Shopping',
        position: const LatLng(37.7849, -122.4294),
      ),
      LocationEntity(
        id: '3',
        name: 'Pizza Shop',
        category: 'Restaurant',
        position: const LatLng(37.7949, -122.4394),
      ),
      LocationEntity(
        id: '4',
        name: 'Cycle Pickup Point 2',
        category: 'Cycle',
        position: const LatLng(37.7749, -122.4494),
      ),
      LocationEntity(
        id: '5',
        name: 'Shopping Mall 2',
        category: 'Shopping',
        position: const LatLng(37.7849, -122.4594),
      ),
      LocationEntity(
        id: '6',
        name: 'Pizza Shop 2',
        category: 'Restaurant',
        position: const LatLng(37.7949, -122.4694),
      ),
      // Add more points...
    ];
  }
}
