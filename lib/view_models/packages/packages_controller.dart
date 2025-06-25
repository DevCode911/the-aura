import 'package:get/get.dart';
import 'package:the_aura/respository/packages/packages_repository.dart';
import 'package:the_aura/view_models/packages/packages_model.dart';

class PackagesController extends GetxController {
  final PackagesRepository packagesRepository = PackagesRepository();
  var packagesList = <PackageData>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
   
    fetchPackages();
    
    super.onInit();
  }

  // in packages_controller.dart
  void fetchPackages() async {
    try {
      isLoading.value = true;

      final allPackages = await packagesRepository.fetchPackagess();
        packagesList.value = allPackages;
    } catch (e) {
      print("Error fetching packages: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
