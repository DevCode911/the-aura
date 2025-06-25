import 'package:get/get.dart';
import 'package:the_aura/services/api_service.dart';

import '../../view_models/category/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<CategoryController>(() => CategoryController(), fenix: true);
  }
}
