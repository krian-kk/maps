import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/features/explore_map/presentation/bloc/map_bloc.dart';
import 'package:maps/features/explore_map/presentation/bloc/map_event.dart';
import 'package:maps/features/explore_map/repository/location_repository.dart';
import 'package:maps/features/product/bloc/product_bloc.dart';
import 'package:maps/features/product/bloc/product_event.dart';
import 'package:maps/features/product/presentation/product_listing.dart';
import 'package:maps/features/product/repository/product_repository.dart';
import 'features/explore_map/presentation/screen/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final productRepository = ProductRepository(dio: Dio());

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (BuildContext context) => productRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ProductBloc>(
              create: (context) =>
                  ProductBloc(productRepository)..add(LoadProductsEvent()),
            ),
          ],
          child: MaterialApp(
            title: 'Flutter Take-Home Assignment',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: ProductListScreen(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
