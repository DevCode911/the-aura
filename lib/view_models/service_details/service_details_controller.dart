import 'package:get/get.dart';
import 'package:the_aura/respository/service_details/service_details_repository.dart';
import 'package:the_aura/view_models/service_details/service_details_model.dart';

import '../../utils/common_utils/snackbar/my_snackbar_widget.dart';

class ServiceDetailsController extends GetxController {
  var serviceDetails = <Data>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchServiceDetails();
  }

  Future<void> fetchServiceDetails() async {
    try {
      isLoading.value = true;

      final categories = await ServiceDetailsRepository().getServiceDetails();

      if (categories.isNotEmpty) {
        serviceDetails.assignAll(categories);
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>${serviceDetails.length}");
      } else {
        serviceDetails.clear(); // or show a message
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
