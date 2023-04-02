import 'package:get/get.dart';
import '../../../features/logic/bindings/details_binding.dart';
import '../../../features/logic/bindings/favorites_binding.dart';
import '../../../features/logic/bindings/main_binding.dart';
import '../../../features/logic/bindings/movies_binding.dart';
import '../../../features/logic/bindings/trailar_binding.dart';
import '../../../features/logic/bindings/trending_binding.dart';
import '../../../features/view/screens/details_screen.dart';
import '../../../features/view/screens/favourites_screen.dart';
import '../../../features/view/screens/trending_screen.dart';
import '../../../features/view/screens/main_screen.dart';
import '../../../features/view/screens/movies_screen.dart';
import '../../../features/view/screens/trailer_screen.dart';

class AppRoutes {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: RoutesPath.initial,
      bindings: [MainBinding(), MoviesBinding(), TrendingBinding()],
      page: () {
        return MainScreen();
      },
    ),
    GetPage(
      name: RoutesPath.moviesScreen,
      binding: MoviesBinding(),
      page: () {
        return const MoviesScreen();
      },
    ),
    GetPage(
      name: RoutesPath.favouritesScreen,
      binding: FavoritesBinding(),
      page: () {
        return  FavouritesScreen();
      },
    ),
    GetPage(
      name: RoutesPath.trendingScreen,
      binding: TrendingBinding(),
      page: () {
        return const TrendingScreen();
      },
    ),
    GetPage(
      name: RoutesPath.detailsScreen,
      binding: DetailsBinding(),
      page: () {
        return DetailsScreen();
      },
    ),
    GetPage(
      name: RoutesPath.trailerScreen,
      binding: TrailarBinding(),
      page: () {
        return const TrailerScreen();
      },
    ),
  ];
}

class RoutesPath {
  static const String initial = '/';
  static const String moviesScreen = '/moviesScreen';
  static const String favouritesScreen = '/favouritesScreen';
  static const String trendingScreen = '/trendingScreen';
  static const String detailsScreen = '/detailsScreen';
  static const String trailerScreen = '/trailerScreen';
}
