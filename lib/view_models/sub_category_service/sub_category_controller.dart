import 'package:get/get.dart';
import 'package:the_aura/respository/sub_category/sub_category_repository.dart';
import 'package:the_aura/view_models/sub_category_service/sub_category_model.dart';

import '../../utils/common_utils/snackbar/my_snackbar_widget.dart';

class SubCategoryController extends GetxController {
  // view service repository
  final SubCategoryRepository viewServiceRepository = SubCategoryRepository();
  var categoryServices = <Data>[].obs;
  var isLoading = false.obs;

  // wish list
  RxBool isWishList = true.obs;
  var whishList = <Data>[].obs;

  // fetch services here
  var selectedServices = <Data>[].obs;
  var maleSelectedServices = <Data>[].obs;
  var womenSelectedServices = <Data>[].obs;

  final showEmptyMessage = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryData();
  }

  // fetch catagory data / all services
  void fetchCategoryData() async {
    try {
      isLoading.value = true;
      showEmptyMessage(false);

      final subCategorysData = await viewServiceRepository.fetchSubCategory();
      categoryServices.assignAll(subCategorysData);

      // Now check if data is empty
      if (categoryServices.isEmpty) {
        showEmptyMessage(true);
      }
    } catch (e) {
      showEmptyMessage(true); // Also show empty message on error
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Add services to category-specific lists
  void addService(Data service) {
    final categoryName = service.categoryData?.name?.toLowerCase() ?? '';

    // Add to category-specific list
    if (categoryName == 'men') {
      if (maleSelectedServices.contains(service)) {
        maleSelectedServices.remove(service);
      } else {
        maleSelectedServices.add(service);
      }
    } else if (categoryName == 'women') {
      if (womenSelectedServices.contains(service)) {
        womenSelectedServices.remove(service);
      } else {
        womenSelectedServices.add(service);
      }
    }

    //  Add/remove from selectedServices so UI updates
    if (selectedServices.contains(service)) {
      selectedServices.remove(service);
    } else {
      selectedServices.add(service);
    }
  }

  // Check if a service is selected for the given category
  RxBool isSelected(Data service) {
    final categoryName = service.categoryData?.name?.toLowerCase() ?? '';
    if (categoryName == 'men') {
      return maleSelectedServices.contains(service).obs;
    } else if (categoryName == 'women') {
      return womenSelectedServices.contains(service).obs;
    }
    return false.obs;
  }

  // Get the count of selected services for a specific category
  int selectedCount(String categoryName) {
    categoryName = categoryName.toLowerCase();
    if (categoryName == 'men') {
      return maleSelectedServices.length;
    } else if (categoryName == 'women') {
      return womenSelectedServices.length;
    }
    return 0;
  }

  // favourite
  void toggleFavourite(Data service) {
    if (whishList.any((item) => item.id == service.id)) {
      whishList.removeWhere((item) => item.id == service.id);
    } else {
      whishList.add(service);
    }
  }

  var cardList = <Data>[].obs;

  // add to cart
  void addToCart(Data service) {
    if (cardList.any((cart) => cart.id == service.id)) {
      // cardList.removeWhere((cart) => cart.id == service.id);
      MySnackBarWidget.showSnackbar(
        title: "${service.name}",
        message: "Product is Alredy added",
        position: SnackPosition.BOTTOM,
      );
    } else {
      cardList.add(service);
    }
  }

  // bootom navigation page
  final RxInt currentIndex = 0.obs;

  void updatePageIndex(int index) {
    currentIndex.value = index;
  }
}
