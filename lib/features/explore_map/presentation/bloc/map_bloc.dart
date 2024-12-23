import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/features/explore_map/presentation/bloc/map_event.dart';
import 'package:maps/features/explore_map/presentation/bloc/map_state.dart';
import 'package:maps/features/explore_map/repository/location_repository.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationRepository repository;

  MapBloc(this.repository) : super(MapState.initial()) {
    on<LoadMarkersEvent>(_loadMarkers);
    on<FilterMarkersEvent>(_filterMarkers);
    on<ToggleDarkModeEvent>((event, emit) {
      emit(state.copyWith(isDarkModeEnabled: !state.isDarkModeEnabled));
    });
  }

  Future<void> _loadMarkers(
    LoadMarkersEvent event,
    Emitter<MapState> emit,
  ) async {
    final locations = await repository.fetchLocations();
    final markers = locations
        .map(
          (location) => Marker(
            markerId: MarkerId(location.id),
            position: location.position,
            infoWindow: InfoWindow(title: location.name),
            icon: BitmapDescriptor.defaultMarker,
          ),
        )
        .toList();
    emit(state.copyWith(markers: markers));
  }

  Future<void> _filterMarkers(
    FilterMarkersEvent event,
    Emitter<MapState> emit,
  ) async {
    final locations = await repository.fetchLocations();
    final filteredMarkers = locations.where((location) {
      return location.category.contains(event.category) == true;
    }).toList();
    final markers = filteredMarkers
        .map(
          (location) => Marker(
            markerId: MarkerId(location.id),
            position: location.position,
            infoWindow: InfoWindow(title: location.name),
            icon: BitmapDescriptor.defaultMarker,
          ),
        )
        .toList();
    emit(state.copyWith(markers: markers));
  }
}
