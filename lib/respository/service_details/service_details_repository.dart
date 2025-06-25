import 'package:the_aura/data/network_api_service.dart';
import 'package:the_aura/view_models/service_details/service_details_model.dart';

import '../../res/api_urls/api_url.dart';

class ServiceDetailsRepository {
  final apiService = NetworkApiService();
  Future<List<Data>> getServiceDetails() async {
    try {
      final response = await apiService.getApi(ApiUrl.serviceDetails);
      final serviceDetails = ServiceDetails.fromJson(response);

      return serviceDetails.data ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
