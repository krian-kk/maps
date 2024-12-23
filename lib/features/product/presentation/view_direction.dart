import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewDirectionsScreen extends StatelessWidget {
  final LatLng source;
  final LatLng destination;

  const ViewDirectionsScreen({
    required this.source,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Directions")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: source,
          zoom: 14,
        ),
        markers: {
          Marker(markerId: MarkerId('source'), position: source),
          Marker(markerId: MarkerId('destination'), position: destination),
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId('route'),
            points: [source, destination],
            color: Colors.blue,
            width: 5,
          ),
        },
      ),
    );
  }
}
