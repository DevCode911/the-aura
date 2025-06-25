import 'package:get/get.dart';
import 'package:the_aura/controller/bottom_navi_controller.dart';

class BottomNaviBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNaviController>(() => BottomNaviController());
  }
}
