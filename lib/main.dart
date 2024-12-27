import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/features/product/bloc/product_bloc.dart';
import 'package:maps/features/product/presentation/product_listing.dart';
import 'package:maps/features/product/repository/product_repository.dart';
import 'package:maps/features/user/bloc/user_bloc.dart';
import 'package:maps/features/user/presentation/user_list.dart';
import 'package:maps/features/user/repository/user_repository.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final productRepository = ProductRepository(dio: Dio());
    final userRepository = UserRepository(dio: Dio());

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (BuildContext context) => userRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<UserBloc>(
              create: (context) => UserBloc(userRepository: userRepository),
            ),
          ],
          child: MaterialApp(
            title: 'Flutter Take-Home Assignment',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const UserList(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
