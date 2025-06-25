import 'package:get/get.dart';
import 'package:the_aura/view_models/services/service_controller.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceController>(() => ServiceController(), fenix: true);
  }
}
