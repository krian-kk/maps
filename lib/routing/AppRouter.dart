import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maps/features/map/presentation/product_map.dart';
import 'package:maps/features/product/bloc/product_bloc.dart';
import 'package:maps/features/product/presentation/product_listing.dart';
import 'package:maps/features/product/repository/product_repository.dart';
import 'package:maps/network/dio_client.dart';

class AppRouter {
  final GoRouter goRouter;

  AppRouter() : goRouter = _router;

  static GoRouter get _router => GoRouter(
        initialLocation: '/',
        routes: <GoRoute>[
          GoRoute(
            path: '/',
            // pageBuilder: (context, state){
            //
            // },
            builder: (context, state) {
              final productRepository =
                  ProductRepositoryImpl(dio: DioClient(''));
              return RepositoryProvider(
                create: (BuildContext context) => productRepository,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<ProductBloc>(
                      create: (context) => ProductBloc(productRepository),
                    ),
                  ],
                  child: const ProductListScreen(),
                ),
              );
            },
          ),
          GoRoute(
            path: '/maps',
            name: "maps",
            // pageBuilder: (context,state){
            //
            // },
            builder: (context, state) {
              return BlocProvider.value(
                value: state.extra! as ProductBloc,
                child: const ProductMapScreen(),
              );
            },
          ),
        ],
      );
}
