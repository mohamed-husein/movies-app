import 'package:get/get.dart';

class MainController extends GetxController{


      RxInt currentIndex = 0.obs;
  void selectItem(index){
    currentIndex.value=index;
  }
}