import 'package:dio/dio.dart';
import 'package:maps/features/user/domain/entity/user.dart';

class UserRepository {
  Dio dio;

  UserRepository({required this.dio});

  Future<List<User>> fetchUser() async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/users',
    );
    try {
      if (response.statusCode == 200) {
        final list = <User>[];
        final data = response.data;
        for (var item in data) {
          list.add(User.fromJson(item));
        }
        return list;
      }
    } catch (e) {
      throw Exception("Unable to fetch");
    }
    return [];
  }
}
