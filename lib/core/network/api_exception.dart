import 'dart:io';

class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final Map<String, dynamic>? details;

  ApiException({
    this.statusCode,
    required this.message,
    this.details,
  });

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// Helper class to parse and normalize exceptions
class ApiErrorHandler {
  static ApiException handle(dynamic error) {
    if (error is ApiException) {
      return error; 
    } else if (error is SocketException) {
      return ApiException(message: "No internet connection. Please check your network.");
    } else if (error is FormatException) {
      return ApiException(message: "Bad response format. Please try again later.");
    } else if (error.toString().contains("TimeoutException")) {
      return ApiException(message: "Request timed out. Please try again.");
    } else {
      return ApiException(message: "Unexpected error occurred: ${error.toString()}");
    }
  }

  ///To parse backend validation errors:
  static ApiException fromResponse(int statusCode, dynamic body) {
    String message = "Something went wrong";
    Map<String, dynamic>? errors;

    if (body is Map<String, dynamic>) {
      // Extracting Possible error messages, which i know.
      message = body['message'] ?? body['error'] ?? message;
      errors = body['errors'];
    }

    switch (statusCode) {
      case 400:
      case 422:
        return ApiException(statusCode: statusCode, message: message, details: errors);
      case 401:
        return ApiException(statusCode: statusCode, message: "Unauthorized. Please log in again.");
      case 403:
        return ApiException(statusCode: statusCode, message: "Access denied.");
      case 404:
        return ApiException(statusCode: statusCode, message: "Resource not found.");
      case 409:
        return ApiException(statusCode: statusCode, message: "Conflict: $message");
      case 500:
      default:
        return ApiException(statusCode: statusCode, message: "Server error. Please try again later.");
    }
  }
}
