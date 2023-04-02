import 'dart:convert';
import 'package:get/get.dart';
import '../../core/utils/app_constants.dart';
import 'storage_services.dart';

import '../model/favorites_model.dart';

// import '../model/favorites_model.dart';

// class FavServices {
//   final StorageServices _services = Get.find<StorageServices>();

//   List<Favorites> getTasks() {
//     final favs = <Favorites>[];

//     jsonDecode(_services.read(AppConstance.favKey).toString())
//         .forEach((e) => favs.add(Favorites.fromJson(e)));
//     return favs;
//   }

//   void writeTask(List<Favorites> fav) async {
//     await _services.write(
//       AppConstance.favKey,
//       json.encode(fav),
//     );
//   }
// }

class FavoritesServices {
  final StorageServices _services = Get.find<StorageServices>();

  List<Favorites> getFavorites() {
    final favorites = <Favorites>[];
  
    final response = _services.read(AppConstance.favKey).toString();
    jsonDecode(response).forEach((e) => favorites.add(Favorites.fromJson(e)));
    return favorites;
  }

  void writeFavorites(List<Favorites> favorites) async {
    await _services.write(
      AppConstance.favKey,
      jsonEncode(favorites),
    );
  }
}


