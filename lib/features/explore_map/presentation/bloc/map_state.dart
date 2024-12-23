import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState extends Equatable {
  final bool isDarkModeEnabled;
  final List<Marker> markers;

  const MapState({
    required this.isDarkModeEnabled,
    required this.markers,
  });

  factory MapState.initial() {
    return const MapState(
      isDarkModeEnabled: false,
      markers: [],
    );
  }

  MapState copyWith({
    bool? isDarkModeEnabled,
    List<Marker>? markers,
  }) {
    return MapState(
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object> get props => [isDarkModeEnabled, markers];
}
