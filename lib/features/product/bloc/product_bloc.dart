import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps/features/product/domain/entities/product.dart';
import 'package:maps/features/product/repository/product_repository.dart';
import 'package:maps/utils/connectivity_utils.dart';
import 'package:maps/utils/location_service.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductLoading()) {
    on<LoadProductsEvent>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
      LoadProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    if (await ConnectivityService.hasInternetConnection() == false) {
      emit(
          ProductError("Failed to load products. Please check your internet."));
    }
    try {
      List<Product> products = await repository.fetchProducts();
      final userLocation = await Geolocator.getCurrentPosition();

      for (var product in products) {
        product.distance = LocationService.getDistanceBetweenTwoCoordinatesInKm(
          userLocation.latitude,
          userLocation.longitude,
          product.coordinates.first,
          product.coordinates.last,
        );
      }

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError("Failed to load products. Please try again"));
    }
  }
}
