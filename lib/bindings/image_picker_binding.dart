import 'package:get/get.dart';
import 'package:the_aura/controller/image_picker_controller.dart';

class ImagePickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());
  }
}
