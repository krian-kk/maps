import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:maps/features/product/bloc/product_bloc.dart';
import 'package:maps/features/product/bloc/product_event.dart';
import 'package:maps/features/product/bloc/product_state.dart';
import 'package:maps/features/product/presentation/product_card.dart';
import 'package:maps/utils/location_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Position? sourceLocation;

  Future<void> _checkLocationPermission() async {
    try {
      sourceLocation = await LocationService.getCurrentLocation();
      BlocProvider.of<ProductBloc>(context).add(LoadProductsEvent());
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _checkLocationPermission();
            },
            child: const Text("Retry"),
          ),
          TextButton(
            onPressed: () {
              // Navigator.of(context).pop();
              Geolocator.openAppSettings();
            },
            child: const Text("Settings"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product List")),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.map),
            onPressed: () {
              context.push("/maps", extra: context.read<ProductBloc>());
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(LoadProductsEvent());
              },
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      context.push('/direction', extra: {
                        "start_lat": sourceLocation?.latitude,
                        "start_long": sourceLocation?.longitude,
                        "end_lat": product.coordinates.first,
                        "end_long": product.coordinates.last
                      });
                    },
                  );
                },
              ),
            );
          } else if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(LoadProductsEvent());
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
