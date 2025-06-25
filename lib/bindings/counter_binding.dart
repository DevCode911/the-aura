import 'package:get/get.dart';
import 'package:the_aura/controller/counter_button_controller.dart';

class CounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CounterButtonController>(() => CounterButtonController());
  }
}
