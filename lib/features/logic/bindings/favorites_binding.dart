
import 'package:get/get.dart';
import '../controller/fav_controller.dart';

class FavoritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoritesController());
   
  }
}
