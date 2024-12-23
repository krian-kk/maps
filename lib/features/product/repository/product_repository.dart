import 'package:dio/dio.dart';
import 'package:maps/features/product/domain/entities/product.dart';

class ProductRepository {
  Dio dio;

  ProductRepository({required this.dio});

  Future<List<Product>> fetchProducts() async {
    final response = await dio.get(
      'https://h2gvbfqo6smwzaby6x7jinzujm0otrjt.lambda-url.eu-west-2.on.aws/',
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
