import 'package:get/get.dart';
import 'package:the_aura/respository/category/category_repository.dart';
import 'package:the_aura/utils/common_utils/snackbar/my_snackbar_widget.dart';

import '../../../view_models/category/category.dart';

class CategoryController extends GetxController {
  final CategoryRepository categoryRepository = CategoryRepository();

  var categoryList = <Category>[].obs;
  var selectedCategoryName = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); //  renamed
  }

  ///  Improved function with proper error handling
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final categories = await categoryRepository.getCategory();

      if (categories.isNotEmpty) {
        categoryList.assignAll(categories);
      } else {
        categoryList.clear();
        MySnackBarWidget.showSnackbar(
          title: "Notice",
          message: "No categories found.",
        );
      }
    } catch (e) {
      MySnackBarWidget.showSnackbar(
        title: "Error",
        message: "Failed to load categories: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
