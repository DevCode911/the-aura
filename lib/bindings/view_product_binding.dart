import 'package:get/get.dart';
import 'package:the_aura/controller/view_product_controller.dart';

class ViewProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewProductController>(() => ViewProductController());
  }
}
