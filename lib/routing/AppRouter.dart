import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/features/direction/presentation/view_direction.dart';
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
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: BlocProvider.value(
                  value: state.extra! as ProductBloc,
                  child: const ProductMapScreen(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                      position: offsetAnimation, child: child);
                },
              );
            },
          ),
          GoRoute(
            path: '/direction',
            name: "direction",
            pageBuilder: (context, state) {
              Map<String, dynamic> args = state.extra as Map<String, dynamic>;
              return CustomTransitionPage(
                key: state.pageKey,
                child: ViewDirectionsScreen(
                  source: LatLng(
                    args["start_lat"] ?? 0.00,
                    args["start_long"] ?? 0.00,
                  ),
                  destination: LatLng(
                    args["end_lat"] ?? 0.00,
                    args["end_long"] ?? 0.00,
                  ),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                      position: offsetAnimation, child: child);
                },
              );
            },
          ),
        ],
      );
}
