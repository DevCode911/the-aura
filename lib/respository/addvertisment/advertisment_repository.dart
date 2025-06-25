import 'package:the_aura/data/network_api_service.dart';
import 'package:the_aura/res/api_urls/api_url.dart';
import 'package:the_aura/view_models/addvertisment/advertisment_model.dart';

class AdvertismentRepository {
  final apiService = NetworkApiService();

  Future<List<Adds>> fetchAddvertisment() async {
    try {
      final response = await apiService.getApi(ApiUrl.addvertisment);
      final addvertismentResponse = Addvertisment.fromJson(response);

      return addvertismentResponse.add ?? [];
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
