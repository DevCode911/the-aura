import 'package:get/get.dart';
import 'package:the_aura/controller/male_service_controller.dart';
import 'package:the_aura/services/api_service.dart';

class MaleServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaleServiceController>(
      () => MaleServiceController(apiService: ApiService()),
    );
  }
}
