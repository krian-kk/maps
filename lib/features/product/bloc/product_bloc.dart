import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps/features/product/domain/entities/product.dart';
import 'package:maps/features/product/repository/product_repository.dart';
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
    try {
      List<Product> products = await repository.fetchProducts();
      final userLocation = await Geolocator.getCurrentPosition();

      for (var product in products) {
        product.distance = Geolocator.distanceBetween(
          userLocation.latitude,
          userLocation.longitude,
          product.coordinates.first,
          product.coordinates.last,
        )/100;
      }

      emit(ProductLoaded(products));
    } catch (e) {
      print(e);
      emit(
          ProductError("Failed to load products. Please check your internet."));
    }
  }
}
