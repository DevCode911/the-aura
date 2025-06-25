import 'package:the_aura/data/network_api_service.dart';
import 'package:the_aura/res/api_urls/api_url.dart';
import 'package:the_aura/view_models/packages/packages_model.dart';

class PackagesRepository {
  final apiService = NetworkApiService();

  Future<List<PackageData>> fetchPackagess() async {
    try {
      final response = await apiService.getApi(ApiUrl.packages);
      // print("API RESPONSE: $response"); //  Add this to verify shape

      final servicesResponse = Packages.fromJson(response);
      return servicesResponse.packagesData ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
