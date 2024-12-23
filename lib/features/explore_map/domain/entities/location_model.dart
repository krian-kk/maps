import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationEntity {
  final String id;
  final String name;
  final String category;
  final LatLng position;

  LocationEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.position,
  });
}
