import 'package:get/get.dart';
import '../controller/trailar_controller.dart';

class TrailarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TrailarController());
  }
}
