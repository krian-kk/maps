import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/features/product/bloc/product_bloc.dart';
import 'package:maps/features/product/bloc/product_state.dart';
import 'package:maps/features/product/domain/entities/product.dart';

class ProductMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Locations")),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ProductMap(products: state.products);
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}

class ProductMap extends StatefulWidget {
  final List<Product> products;

  const ProductMap({Key? key, required this.products}) : super(key: key);

  @override
  _ProductMapState createState() => _ProductMapState();
}

class _ProductMapState extends State<ProductMap> {
  late GoogleMapController _controller;

  Set<Marker> _buildMarkers(List<Product> products) {
    return products.map((product) {
      return Marker(
        markerId: MarkerId(product.title ?? ''),
        position: LatLng(product.coordinates.first, product.coordinates.last),
        infoWindow: InfoWindow(title: product.title),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final markers = _buildMarkers(widget.products);

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.products.first.coordinates.first,
          widget.products.first.coordinates.last,
        ),
        zoom: 10,
      ),
      markers: markers,
      onMapCreated: (controller) {
        _controller = controller;
      },
    );
  }
}
