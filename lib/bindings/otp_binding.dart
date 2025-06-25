import 'package:get/get.dart';
import 'package:the_aura/controller/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(() => OtpController());
  }
}
