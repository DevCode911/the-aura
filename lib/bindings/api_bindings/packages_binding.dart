import 'package:get/get.dart';
import 'package:the_aura/view_models/packages/packages_controller.dart';

class PackagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackagesController>(() => PackagesController());
  }
}
