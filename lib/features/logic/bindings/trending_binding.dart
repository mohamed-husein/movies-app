import 'package:get/get.dart';
import '../controller/trending_controller.dart';

class TrendingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TrendingController());
  }
}