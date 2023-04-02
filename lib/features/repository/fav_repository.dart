import '../model/favorites_model.dart';

import '../services/fav_services.dart';


class FavoritesRepository {
  final FavoritesServices favoritesServices;

  FavoritesRepository({required this.favoritesServices});

  List<Favorites> readFavorites() => favoritesServices.getFavorites();
  void writeFavorites(List<Favorites> favorites) =>  favoritesServices.writeFavorites(favorites);
}