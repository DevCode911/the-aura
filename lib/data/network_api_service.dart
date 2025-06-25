import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:the_aura/data/app_exception.dart';
import 'package:the_aura/data/base_api_service.dart';

class NetworkApiService extends BaseApiServices {
  // GET request
  @override
  Future<dynamic> getApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return _handleResponse(response);
    } on SocketException {
      throw InternetException("No Internet Connection");
    } catch (e) {
      throw FetchDataException("Unexpected error: $e");
    }
  }

  // POST request
  @override
  Future<dynamic> postApi(dynamic data, String url) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );
      return _handleResponse(response);
    } on SocketException {
      throw InternetException("No Internet Connection");
    } catch (e) {
      throw FetchDataException("Unexpected error: $e");
    }
  }

  // PATCH request
  @override
  Future<dynamic> patchApi(dynamic data, String url) async {
    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );
      return _handleResponse(response);
    } on SocketException {
      throw InternetException("No Internet Connection");
    } catch (e) {
      throw FetchDataException("Unexpected error: $e");
    }
  }

  // DELETE request
  @override
  Future<void> deleteApi(String url) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );
      _handleResponse(response);
    } on SocketException {
      throw InternetException("No Internet Connection");
    } catch (e) {
      throw FetchDataException("Unexpected error: $e");
    }
  }

  // 🔁 Handle response based on status code
  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        return response.body.isNotEmpty ? json.decode(response.body) : null;
      case 400:
        throw FetchDataException("Bad Request: ${response.body}");
      case 401:
      case 403:
        throw FetchDataException("Unauthorized: ${response.body}");
      case 500:
      default:
        throw ServerException(
          "Server Error: ${response.statusCode}, ${response.body}",
        );
    }
  }
}
