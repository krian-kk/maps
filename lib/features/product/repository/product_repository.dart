import 'package:dio/dio.dart';
import 'package:maps/features/product/domain/entities/product.dart';
import 'package:maps/network/dio_client.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts();
}

class ProductRepositoryImpl implements ProductRepository {
  DioClient dio;

  ProductRepositoryImpl({required this.dio});

  @override
  Future<List<Product>> fetchProducts() async {
    final response = await dio.get(
      'https://prcddzpsk5p33eazh5ykzbj4ra0xwyhk.lambda-url.eu-west-2.on.aws/',
    );
    try {
      if (response.statusCode == 200) {
        final list = <Product>[];
        final data = response.data;
        for (var item in data) {
          list.add(Product.fromJson(item));
        }
        return list;
      }
    } catch (e) {
      throw Exception("Unable to fetch");
    }
    return [];
  }
}
