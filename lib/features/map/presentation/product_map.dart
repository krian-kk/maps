import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/features/product/bloc/product_bloc.dart';
import 'package:maps/features/product/bloc/product_state.dart';
import 'package:maps/features/product/domain/entities/product.dart';

class ProductMapScreen extends StatelessWidget {
  const ProductMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Locations")),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
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
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        product.imageUrl ?? '',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey,
                          height: 150,
                          width: double.infinity,
                          child: const Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Product Title
                    Text(
                      product.title ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Product Description
                    Text(
                      product.body ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Distance Information
                    Text(
                      "Distance: ${product.distance?.toStringAsFixed(2)} km",
                      style: const TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          });
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
        zoom: 1,
      ),
      markers: markers,
      onMapCreated: (controller) {
        _controller = controller;
      },
    );
  }
}
