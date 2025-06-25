import 'package:get/get.dart';
import 'package:the_aura/respository/addvertisment/addvertisment_controller.dart';

class AddvertismentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddvertismentController>(() => AddvertismentController());
  }
}
