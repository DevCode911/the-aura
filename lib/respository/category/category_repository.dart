import 'package:the_aura/data/network_api_service.dart';
import 'package:the_aura/res/api_urls/api_url.dart';

import '../../view_models/category/category.dart';

class CategoryRepository {
  final apiService = NetworkApiService();

  Future<List<Category>> getCategory() async {
    try {
      final response = await apiService.getApi(ApiUrl.categoryApi);
      final categoryResponse = CategoryResponse.fromJson(response);

      return categoryResponse.data ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
