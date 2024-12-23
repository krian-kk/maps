import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/features/explore_map/presentation/bloc/map_bloc.dart';
import 'package:maps/features/explore_map/presentation/bloc/map_event.dart';
import 'package:maps/features/explore_map/presentation/bloc/map_state.dart';
import 'package:maps/utils/map_styles.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Explore Map")),
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return GoogleMap(
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7649, -122.4194),
              zoom: 12.5,
            ),
            mapType: state.isDarkModeEnabled ? MapType.hybrid : MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              final mapStyle = state.isDarkModeEnabled
                  ? MapStyle.darkMapStyle
                  : MapStyle.lightMapStyle;
              controller.setMapStyle(mapStyle);
            },
            markers: state.markers.map((marker) {
              return Marker(
                markerId: marker.markerId,
                position: marker.position,
                onTap: () {
                  // Example: Display info in BottomSheet
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      padding: EdgeInsets.all(16),
                      child: Text(marker.infoWindow.title ?? "Details"),
                    ),
                  );
                },
                icon: marker.icon,
              );
            }).toSet(),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "Cycle",
            onPressed: () {
              context.read<MapBloc>().add(FilterMarkersEvent('Cycle'));
            },
            child: const Icon(Icons.directions_bike),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "Shopping",
            onPressed: () {
              context.read<MapBloc>().add(FilterMarkersEvent('Shopping'));
            },
            child: const Icon(Icons.shopping_cart),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "Restaurant",
            onPressed: () {
              context.read<MapBloc>().add(FilterMarkersEvent('Restaurant'));
            },
            child: const Icon(Icons.restaurant),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "DarkModeToggle",
            onPressed: () {
              context.read<MapBloc>().add(ToggleDarkModeEvent());
            },
            child: Icon(Icons.nightlight_round, color: Colors.white),
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
