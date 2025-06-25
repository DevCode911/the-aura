import 'package:get/get.dart';
import 'package:the_aura/models/male_services.dart';
import 'package:the_aura/services/api_service.dart';

class MaleServiceController extends GetxController {
  final Rxn<MaleServices> selectedPackage = Rxn<MaleServices>();
  void selectPackage(MaleServices service) {
    selectedPackage.value = service;
  }

  var maleServicesList = <MaleServices>[].obs;
  final ApiService apiService;

  MaleServiceController({required this.apiService});

  @override
  void onInit() {
    super.onInit();
    fetchMaleServices();
  }

  void fetchMaleServices() async {
    try {
      var maleService = await apiService.getMaleService();
      maleServicesList.assignAll(maleService);
    } catch (e) {
      print("Error fetching male services: $e");
    }
  }
}
