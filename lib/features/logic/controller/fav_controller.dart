

import 'package:get/get.dart';
import '../../model/favorites_model.dart';

import '../../repository/fav_repository.dart';
import '../../services/fav_services.dart';

class FavoritesController extends GetxController {
    final _favService =
      FavoritesRepository(favoritesServices: FavoritesServices());

  final favs = <Favorites>[].obs;

  bool addFavorites(Favorites fav) {
    if (favs.contains(fav)) {
      favs.remove(fav);
      return false;
    }
    favs.add(fav);
    return true;
  }

  bool inFav(int id) {
    return favs.any((element) => element.id == id);
  }

  @override
  void onInit() {
    super.onInit();
    favs.assignAll(
      _favService.readFavorites(),
    );
    ever(favs, (_) => _favService.writeFavorites(favs));
  }
}
