import '../../data/network_api_service.dart';
import '../../res/api_urls/api_url.dart';
import '../../view_models/services/service_model.dart';

class ServiceRepository {
  final apiService = NetworkApiService();

  Future<List<Service>> fetchServices() async {
    try {
      final response = await apiService.getApi(ApiUrl.serviceDetails);
      final servicesResponse = Services.fromJson(response);

      return servicesResponse.data ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
