import 'package:get/get.dart';
import 'package:the_aura/data/network_api_service.dart';
import 'package:the_aura/respository/addvertisment/advertisment_repository.dart';
import 'package:the_aura/view_models/addvertisment/advertisment_model.dart';

class AddvertismentController extends GetxController {
  final apiService = NetworkApiService();
  var isLoading = false.obs;
  final AdvertismentRepository addvertismentRepository =
      AdvertismentRepository();
  var addsList = <Adds>[].obs;

  @override
  void onInit() {
    fetchAdds();
    super.onInit();
  }

  void fetchAdds() async {
    try {
      isLoading.value = true;

      final addsData = await addvertismentRepository.fetchAddvertisment();
      addsList.assignAll(addsData);
      print("..................${addsData}");
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
