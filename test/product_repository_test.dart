import 'package:flutter_test/flutter_test.dart';
import 'package:maps/features/product/repository/product_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'product_repository_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ProductRepository repository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    repository = ProductRepository(dio: mockDio);
  });

  test("Fetch products successfully", () async {
    when(mockDio.get(any)).thenAnswer((_) async => Response(
          data: [
            {
              "title": "Product 1",
              "description": "Sample product",
              "image": "https://example.com/image.jpg",
              "coordinates": [0.00, 0.00]
            }
          ],
          statusCode: 200,
          requestOptions: RequestOptions(path: ""),
        ));

    final products = await repository.fetchProducts();
    expect(products.length, 1);
    expect(products.first.title, "Product 1");
  });

  test("API failure throws an exception", () async {
    when(mockDio.get(any)).thenThrow(DioError(
        requestOptions: RequestOptions(path: ""),
        response:
            Response(statusCode: 500, requestOptions: RequestOptions(path: "")),
        type: DioErrorType.badResponse));

    expect(() => repository.fetchProducts(), throwsException);
  });
}
