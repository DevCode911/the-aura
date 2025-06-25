import 'package:the_aura/data/network_api_service.dart';
import 'package:the_aura/res/api_urls/api_url.dart';

import '../../view_models/sub_category_service/sub_category_model.dart';

class SubCategoryRepository {
  final apiService = NetworkApiService();

  Future<List<Data>> fetchSubCategory() async {
    try {
      final response = await apiService.getApi(ApiUrl.subCategory);
      final viewServiceResponse = SubCategory.fromJson(response);
      return viewServiceResponse.data ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
