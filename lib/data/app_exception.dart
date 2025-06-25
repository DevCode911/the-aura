// Custom exception class to handle different types of errors
class AppException implements Exception {
  final String? message;
  final String? prefix;

  // Constructor with optional parameters
  AppException([this.message, this.prefix]);

  // How the error will appear in logs or UI
  @override
  String toString() {
    return '$prefix: $message';
  }
}

// 🧱 Specific types of errors

// No internet connection
class InternetException extends AppException {
  InternetException([String? message])
      : super(message, "No Internet");
}

// API request took too long
class RequestTimeoutException extends AppException {
  RequestTimeoutException([String? message])
      : super(message, "Request Timeout");
}

// Server responded with error (500, etc.)
class ServerException extends AppException {
  ServerException([String? message])
      : super(message, "Server Error");
}

// URL is wrong or badly formatted
class InvalidUrlException extends AppException {
  InvalidUrlException([String? message])
      : super(message, "Invalid URL");
}

// Used for other unexpected fetch errors
class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error");
}
