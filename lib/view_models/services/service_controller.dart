import 'package:get/get.dart';
import 'package:the_aura/view_models/services/service_model.dart';

import '../../respository/services/service_repository.dart';
import '../../utils/common_utils/snackbar/my_snackbar_widget.dart';

class ServiceController extends GetxController {
  final ServiceRepository serviceRepository = ServiceRepository();
  var services = <Service>[].obs;
  var isLoading = false.obs;

  // wish list
  RxBool isWishList = true.obs;
  var wishList = <Service>[].obs;

  // selected services
  var selectedServices = <Service>[].obs;
  var maleSelectedServices = <Service>[].obs;
  var womenSelectedServices = <Service>[].obs;

  final showEmptyMessage = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  // fetch all services
  void fetchServices() async {
    try {
      isLoading.value = true;
      showEmptyMessage(false);

      final servicesData = await serviceRepository.fetchServices();
      services.assignAll(servicesData);

      if (services.isEmpty) {
        showEmptyMessage(true);
      }
    } catch (e) {
      showEmptyMessage(true);
      MySnackBarWidget.showSnackbar(
        title: "Error",
        message: "Failed to load services: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Add services to category-specific lists
  void addService(Service service) {
    final categoryName = service.categoryData?.name?.toLowerCase() ?? '';

    if (categoryName == 'men') {
      if (maleSelectedServices.contains(service)) {
        maleSelectedServices.remove(service);
      } else {
        maleSelectedServices.add(service);
        print("Adding service: ${service.id}");
      }
    } else if (categoryName == 'women') {
      if (womenSelectedServices.contains(service)) {
        womenSelectedServices.remove(service);
      } else {
        womenSelectedServices.add(service);
      }
    }

    if (selectedServices.contains(service)) {
      selectedServices.remove(service);
    } else {
      selectedServices.add(service);
    }
  }

  // Check if a service is selected
  RxBool isSelected(Service service) {
    final categoryName = service.categoryData?.name?.toLowerCase() ?? '';
    if (categoryName == 'men') {
      return maleSelectedServices.contains(service).obs;
    } else if (categoryName == 'women') {
      return womenSelectedServices.contains(service).obs;
    }
    return false.obs;
  }

  // Get count of selected services for a category
  int selectedCount(String categoryName) {
    categoryName = categoryName.toLowerCase();
    if (categoryName == 'men') {
      return maleSelectedServices.length;
    } else if (categoryName == 'women') {
      return womenSelectedServices.length;
    }
    return 0;
  }

  // Toggle favorite
  void toggleFavorite(Service service) {
    if (wishList.any((item) => item.id == service.id)) {
      wishList.removeWhere((item) => item.id == service.id);
    } else {
      wishList.add(service);
    }
  }

  // Shopping cart
  var cartItems = <Service>[].obs;

  void addToCart(Service service) {
    if (cartItems.any((item) => item.id == service.id)) {
      MySnackBarWidget.showSnackbar(
        title: "${service.serviceName}",
        message: "Service is already added to cart",
        position: SnackPosition.BOTTOM,
      );
    } else {
      cartItems.add(service);
      MySnackBarWidget.showSnackbar(
        title: "Added to Cart",
        message: "${service.serviceName} added to your cart",
        position: SnackPosition.BOTTOM,
      );
    }
  }

  // Bottom navigation
  final RxInt currentIndex = 0.obs;

  void updatePageIndex(int index) {
    currentIndex.value = index;
  }

  // Filter services by category
  List<Service> getServicesByCategory(String categoryName) {
    return services
        .where(
          (service) =>
              service.categoryData?.name?.toLowerCase() ==
              categoryName.toLowerCase(),
        )
        .toList();
  }

  // calculation
  double calculation(String categoryName) {
    categoryName = categoryName.toLowerCase();
    final service =
        categoryName == 'men'
            ? maleSelectedServices
            : categoryName == 'women'
            ? womenSelectedServices
            : [];
    return service.fold(0.0, (sum, item) => sum + (item.price ?? 0));
  }

  double discount(String categoryName) {
    categoryName = categoryName.toLowerCase();
    final services =
        categoryName == 'men'
            ? maleSelectedServices
            : categoryName == 'women'
            ? womenSelectedServices
            : [];
    return services.fold(0.0, (sum, item) => sum + (item.discount ?? 0));
  }
}
