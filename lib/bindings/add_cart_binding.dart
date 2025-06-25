import 'package:get/get.dart';
import 'package:the_aura/controller/add_cart_controller.dart';

class AddCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCartController>(() => AddCartController());
  }
}
