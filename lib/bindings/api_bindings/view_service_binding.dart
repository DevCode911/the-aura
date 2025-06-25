import 'package:get/get.dart';
import 'package:the_aura/view_models/sub_category_service/sub_category_controller.dart';

class ViewServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubCategoryController>(() => SubCategoryController());
  }
}
