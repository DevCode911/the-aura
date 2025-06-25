import 'dart:convert';
import 'package:the_aura/models/male_services.dart';
import 'package:http/http.dart' as http;

import '../view_models/category/category.dart';

class ApiService {
  static const String baseUrl = "https://68468e847dbda7ee7aaf7125.mockapi.io/";
  static const String categoryUrl =
      "https://theaura.pythonanywhere.com/category/";

  Future<List<MaleServices>> getMaleService() async {
    final response = await http.get(Uri.parse("$baseUrl/theaura"));
    if (response.statusCode == 200) {
      List maleServices = jsonDecode(response.body);
      return maleServices
          .map((services) => MaleServices.fromJson(services))
          .toList();
    } else {
      throw Exception("Failed to get male services");
    }
  }

  // Category Get
  Future<List<Category>> getCategory() async {
    final response = await http.get(Uri.parse(categoryUrl));
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final categoryResponse = CategoryResponse.fromJson(jsonBody);
      return categoryResponse.data ?? [];
    } else {
      throw Exception("Failed to fetch categories");
    }
  }
}
