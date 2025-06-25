import 'package:get/get.dart';
import 'package:the_aura/controller/favourite_controller.dart';


class FavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouriteController>(() => FavouriteController());
  }
}
